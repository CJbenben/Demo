//
//  ARViewController.m
//  Demo
//
//  Created by chenxiaojie on 2018/12/26.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "ARViewController.h"
#import "MGFacepp.h"
#import <AVFoundation/AVFoundation.h>
//#import "opencv.php"
//#import <opencv2/opencv.php>
//#import <opencv2 imgproc="" typ∫es_c.h="">
//#import <opencv2 imgproc="" imgproc_c.h="">
//#import <opencv2 imgcodecs="" ios.h="">
//#import <opencv2 opencv.php="">

@interface ARViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureMetadataOutputObjectsDelegate>

@property (strong, nonatomic) MGFacepp *markManager;

@property (nonatomic,strong) AVCaptureSession *session;
@property (nonatomic,strong) UIImageView *cameraView;
@property (nonatomic,strong) dispatch_queue_t sample;
@property (nonatomic,strong) dispatch_queue_t faceQueue;
@property (nonatomic,copy) NSArray *currentMetadata;

@end

@implementation ARViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _currentMetadata = [NSMutableArray arrayWithCapacity:0];
    
    [self.view addSubview: self.cameraView];
    
    _sample = dispatch_queue_create("sample", NULL);
    _faceQueue = dispatch_queue_create("face", NULL);
    
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    AVCaptureDevice *deviceF;
    for (AVCaptureDevice *device in devices )
    {
        if ( device.position == AVCaptureDevicePositionFront )
        {
            deviceF = device;
            break;
        }
    }
    
    AVCaptureDeviceInput*input = [[AVCaptureDeviceInput alloc] initWithDevice:deviceF error:nil];
    AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
    
    [output setSampleBufferDelegate:self queue:_sample];
    
    AVCaptureMetadataOutput *metaout = [[AVCaptureMetadataOutput alloc] init];
    [metaout setMetadataObjectsDelegate:self queue:_faceQueue];
    self.session = [[AVCaptureSession alloc] init];
    
    
    [self.session beginConfiguration];
    if ([self.session canAddInput:input]) {
        [self.session addInput:input];
    }
    
    if ([self.session canSetSessionPreset:AVCaptureSessionPreset640x480]) {
        [self.session setSessionPreset:AVCaptureSessionPreset640x480];
    }
    if ([self.session canAddOutput:output]) {
        [self.session addOutput:output];
    }
    
    if ([self.session canAddOutput:metaout]) {
        [self.session addOutput:metaout];
    }
    [self.session commitConfiguration];
    
    NSString     *key           = (NSString *)kCVPixelBufferPixelFormatTypeKey;
    NSNumber     *value         = [NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA];
    NSDictionary *videoSettings = [NSDictionary dictionaryWithObject:value forKey:key];
    
    [output setVideoSettings:videoSettings];
    
    //这里 我们告诉要检测到人脸 就给我一些反应，里面还有QRCode 等 都可以放进去，就是 如果视频流检测到了你要的 就会出发下面第二个代理方法
    [metaout setMetadataObjectTypes:@[AVMetadataObjectTypeFace]];
    
    AVCaptureSession* session = (AVCaptureSession *)self.session;
    //前置摄像头一定要设置一下 要不然画面是镜像
    for (AVCaptureVideoDataOutput* output in session.outputs) {
        for (AVCaptureConnection * av in output.connections) {
            //判断是否是前置摄像头状态
            if (av.supportsVideoMirroring) {
                //镜像设置
                av.videoOrientation = AVCaptureVideoOrientationPortrait;
                av.videoMirrored = YES;
            }
        }
    }
    [self.session startRunning];

}

#pragma mark - AVCaptureSession Delegate -
- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    
    NSMutableArray *bounds = [NSMutableArray arrayWithCapacity:0];
    //每一帧，我们都看一下  self.currentMetadata 里面有没有东西，然后将里面的
    //AVMetadataFaceObject 转换成  AVMetadataObject，其中AVMetadataObject 的bouns 就是人脸的位置 ，我们将bouns 存到数组中
    for (AVMetadataFaceObject *faceobject in self.currentMetadata) {
        AVMetadataObject *face = [output transformedMetadataObjectForMetadataObject:faceobject connection:connection];
        [bounds addObject:[NSValue valueWithCGRect:face.bounds]];
    }
    
//    //转换成UIImage
    UIImage *image = [self imageFromPixelBuffer:sampleBuffer];
//    cv::Mat mat;
//    //转换成cv::Mat
//    UIImageToMat(image, mat);
//
//    for (NSValue *rect in bounds) {
//        CGRect r = [rect CGRectValue];
//        //画框
//        cv::rectangle(mat, cv::Rect(r.origin.x,r.origin.y,r.size.width,r.size.height), cv::Scalar(255,0,0,1));
//    }
//
//    //这里不考虑性能 直接怼Image
//    dispatch_async(dispatch_get_main_queue(), ^{
//        self.cameraView.image = MatToUIImage(mat);
//    });
//
}
- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    //当检测到了人脸会走这个回调
    _currentMetadata = metadataObjects;
}
- (UIImage*)imageFromPixelBuffer:(CMSampleBufferRef)p {
    CVImageBufferRef buffer;
    buffer = CMSampleBufferGetImageBuffer(p);
    
    CVPixelBufferLockBaseAddress(buffer, 0);
    uint8_t *base;
    size_t width, height, bytesPerRow;
    base = (uint8_t *)CVPixelBufferGetBaseAddress(buffer);
    width = CVPixelBufferGetWidth(buffer);
    height = CVPixelBufferGetHeight(buffer);
    bytesPerRow = CVPixelBufferGetBytesPerRow(buffer);
    
    CGColorSpaceRef colorSpace;
    CGContextRef cgContext;
    colorSpace = CGColorSpaceCreateDeviceRGB();
    cgContext = CGBitmapContextCreate(base, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(colorSpace);
    
    CGImageRef cgImage;
    UIImage *image;
    cgImage = CGBitmapContextCreateImage(cgContext);
    image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    CGContextRelease(cgContext);
    
    CVPixelBufferUnlockBaseAddress(buffer, 0);
    
    
    return image;
}

- (UIImageView *)cameraView
{
    if (!_cameraView) {
        _cameraView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        //不拉伸
        _cameraView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _cameraView;
}

//- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
//{
//
//    NSMutableArray *bounds = [NSMutableArray arrayWithCapacity:0];
//    for (AVMetadataFaceObject *faceobject in self.currentMetadata) {
//        AVMetadataObject *face = [output transformedMetadataObjectForMetadataObject:faceobject connection:connection];
//        [bounds addObject:[NSValue valueWithCGRect:face.bounds]];
//    }
//
//    //转换成UIImage
//    UIImage *image = [self imageFromPixelBuffer:sampleBuffer];
//    cv::Mat mat;
//    //转换成cv::Mat
//    UIImageToMat(image, mat);
//
//    for (NSValue *rect in bounds) {
//        CGRect r = [rect CGRectValue];
//        //画框
//        cv::rectangle(mat, cv::Rect(r.origin.x,r.origin.y,r.size.width,r.size.height), cv::Scalar(255,0,0,1));
//    }
//
//    //这里不考虑性能 直接怼Image
//    dispatch_async(dispatch_get_main_queue(), ^{
//        self.cameraView.image = MatToUIImage(mat);
//    });
//}









- (void)initSDK {
    
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:KMGFACEMODELNAME ofType:nil];
    NSData *modelData = [NSData dataWithContentsOfFile:modelPath];
    self.markManager = [[MGFacepp alloc] initWithModel:modelData faceppSetting:^(MGFaceppConfig *config) {
        config.orientation = 90;
        config.pixelFormatType = PixelFormatTypeRGBA;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self openVideo22];
}

- (void)openVideo22 {
    AVAuthorizationStatus authStatus =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) {
        [self showAVAuthorizationStatusDeniedAlert];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (granted) {
                    [self showDetectViewController];
                } else {
                    [self showAVAuthorizationStatusDeniedAlert];
                }
            });
        }];
    } else {
        [self showDetectViewController];
    }
}

- (void)showAVAuthorizationStatusDeniedAlert{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"alert_title_camera",nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:NSLocalizedString(@"alert_action_ok",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)detectSampleBuffer:(CMSampleBufferRef)sampleBuffer {
    MGImageData *imageData = [[MGImageData alloc] initWithSampleBuffer:sampleBuffer];
    [self.markManager beginDetectionFrame];
    
    NSArray *tempArray = [self.markManager detectWithImageData:imageData];
    NSUInteger faceCount = tempArray.count;
    NSLog(@"face Count : %zd",faceCount);
    for (MGFaceInfo *faceInfo in tempArray) {
        [self.markManager GetGetLandmark:faceInfo isSmooth:YES pointsNumber:106];
        NSLog(@"landmark - %@",faceInfo.points);
    }
    [self.markManager endDetectionFrame];
    
}

- (void)showDetectViewController{
//    MCSetModel *record = self.dataArray[0];
//    MCSetModel *face3D = self.dataArray[1];
//    MCSetModel *debug = self.dataArray[2];
//    MCSetModel *rect = self.dataArray[3];
//    MCSetModel *count = self.dataArray[4];
//    MCSetModel *camera = self.dataArray[5];
//    MCSetModel *sizeModel = self.dataArray[6];
//    MCSetModel *space = self.dataArray[7];
//    MCSetModel *info = self.dataArray[8];
//    MCSetModel *size = self.dataArray[9];
//    MCSetModel *tracking = self.dataArray[10];
//    MCSetModel *trackingMode = self.dataArray[11];
//    MCSetModel *faceCompare = self.dataArray[12];
//    
//    int pointCount = count.boolValue == NO ? 81 : 106;
//    int faceSize = (int)sizeModel.intValue;
//    int internal = (int)space.intValue;
//    BOOL recording = record.boolValue;
//    BOOL hasDetectBox = rect.boolValue;
//    
//    MGDetectROI detectROI = MGDetectROIMake(0, 0, 0, 0);
//    CGRect detectRect = CGRectNull;
//    if (hasDetectBox) {
//        CGFloat angeleW = size.sizeValue.width * 0.5;
//        CGFloat angeleL = (size.sizeValue.width - angeleW)/2;
//        CGFloat angeleT = (size.sizeValue.height-angeleW)/2;
//        detectROI = MGDetectROIMake(angeleT, angeleL, angeleW+angeleT, angeleW+angeleL);
//        detectRect = CGRectMake(detectROI.bottom,
//                                detectROI.right,
//                                detectROI.bottom,
//                                detectROI.left);
//    }
//    NSString *modelPath = [[NSBundle mainBundle] pathForResource:KMGFACEMODELNAME ofType:@""];
//    NSData *modelData = [NSData dataWithContentsOfFile:modelPath];
//    
//    int maxFaceCount = 0;
//    if (tracking.boolValue) {
//        maxFaceCount = 1;
//    }
//    
//    MGFacepp *markManager = [[MGFacepp alloc] initWithModel:modelData
//                                               maxFaceCount:maxFaceCount
//                                              faceppSetting:^(MGFaceppConfig *config) {
//                                                  config.minFaceSize = faceSize;
//                                                  config.interval = internal;
//                                                  config.orientation = 90;
//                                                  switch (trackingMode.intValue) {
//                                                      case 1:
//                                                          config.detectionMode = MGFppDetectionModeTrackingFast;
//                                                          break;
//                                                      case 2:
//                                                          config.detectionMode = MGFppDetectionModeTrackingRobust;
//                                                          break;
//                                                      case 3:
//                                                          config.detectionMode = MGFppDetectionModeTrackingRect;
//                                                          break;
//                                                          
//                                                      default:
//                                                          config.detectionMode = MGFppDetectionModeTrackingFast;
//                                                          break;
//                                                  }
//                                                  
//                                                  config.detectROI = detectROI;
//                                                  config.pixelFormatType = PixelFormatTypeRGBA;
//                                              }];
//    
//    
//    AVCaptureDevicePosition device = [self getCamera:camera.boolValue];
//    MGVideoManager *videoManager = [MGVideoManager videoPreset:size.videoPreset
//                                                devicePosition:device
//                                                   videoRecord:recording
//                                                    videoSound:NO];
//    
//    MGVideoViewController *videoController = [[MGVideoViewController alloc] initWithNibName:nil bundle:nil];
//    videoController.detectRect = detectRect;
//    videoController.videoSize = size.sizeValue;
//    videoController.videoManager = videoManager;
//    videoController.markManager = markManager;
//    videoController.debug = debug.boolValue;
//    videoController.pointsNum = pointCount;
//    videoController.show3D = face3D.boolValue;
//    videoController.faceInfo = info.boolValue;
//    videoController.faceCompare = faceCompare.boolValue;
//    switch (trackingMode.intValue) {
//        case 1:
//            videoController.detectMode = MGFppDetectionModeTrackingFast;
//            break;
//        case 2:
//            videoController.detectMode = MGFppDetectionModeTrackingRobust;
//            break;
//        case 3:
//            videoController.detectMode = MGFppDetectionModeTrackingRect;
//            break;
//            
//        default:
//            videoController.detectMode = MGFppDetectionModeTrackingFast;
//            break;
//    }
//    
//    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:videoController];
//    [self.navigationController presentViewController:navi animated:YES completion:nil];
}
                              
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
