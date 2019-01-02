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

@interface ARViewController ()

@property (strong, nonatomic) MGFacepp *markManager;

@end

@implementation ARViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
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
