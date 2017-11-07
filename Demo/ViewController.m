//
//  ViewController.m
//  Demo
//
//  Created by ChenJie on 2017/11/2.
//  Copyright © 2017年 ChenJie. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Country.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>

@property (nonatomic, copy) Person *person;
@property (nonatomic, strong) Person *person1;
@property (nonatomic, copy) NSMutableArray *dataAry;

@property (nonatomic, strong) CLLocationManager *locationManger;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

//    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"1", @"2", nil];
//    self.dataAry = arr;
//    [arr addObject:@"3"];
//    NSLog(@"%@", self.dataAry);
    
    //[self test];
    
    
    [self startLocation];
}

- (void)startLocation {
    // 判断定位功是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManger = [[CLLocationManager alloc]init];
        _locationManger.delegate = self;
        [_locationManger requestAlwaysAuthorization];
        [_locationManger requestWhenInUseAuthorization];
        // 设置寻址经度
        _locationManger.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManger.distanceFilter = 5.0;
        [_locationManger startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    // 打印当前经纬度
    NSLog(@"%f==%f", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
    
    // 地理反编码  可以根据地理坐标确定地理位置信息 (街道门派)
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            NSString *currentCity = placeMark.locality;
            
            if (!currentCity) {
                currentCity = @"无法定位当前城市";
            }
            NSLog(@"当前国家==%@", placeMark.country);
            NSLog(@"当前城市==%@", currentCity);
            NSLog(@"当前位置==%@", placeMark.subLocality);
            NSLog(@"当前街道==%@", placeMark.thoroughfare);
            NSLog(@"当前具体位置==%@", placeMark.name);
        }
        
        else if (error == nil && placemarks.count == 0){
            NSLog(@"no location and error return");
        }
        
        else if (error) {
            NSLog(@"location error %@", error);
        }
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
}










- (void)test{
    Country * country = [[Country alloc] init];
    country.name = @"countr2";
    
    Person *person = [[Person alloc] init];
    self.person = person;
    self.person.name = @"person";
    self.person.country = country;
    self.person.country.name =  @"country";

    NSLog(@"%@ %@", self.person.name ,self.person.country.name);
    
//    self.person1 = [[Person alloc] init];
//    self.person1.name = @"person 1";
//    self.person1.country.name =  @"country1";
//
//    NSLog(@"%@ %@", self.person1.name ,self.person1.country.name);
//
//
//    self.person.country =  country;
//
//    NSLog(@"%@ %@", self.person.name ,self.person.country.name);
//
//    self.person1.country =  country;
//
//    NSLog(@"%@ %@", self.person1.name ,self.person1.country.name);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
