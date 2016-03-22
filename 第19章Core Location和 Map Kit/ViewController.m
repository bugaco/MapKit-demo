//
//  ViewController.m
//  第19章Core Location和 Map Kit
//
//  Created by 李懿哲 on 3/21/16.
//  Copyright © 2016 李懿哲. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建一个位置管理器
    self.locationManager = [CLLocationManager new];
    //设定代理和精度
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //设置距离筛选器
//    self.locationManager.distanceFilter = 1;
    [self.locationManager requestWhenInUseAuthorization];
//    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
    self.mapView.showsUserLocation = YES;
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *newLocation = [locations lastObject];
    NSString *latitudeString = [NSString stringWithFormat:@"%g\u00b0", newLocation.coordinate.latitude];
    self.latitudeLabel.text = latitudeString;
    
    NSString *longitudeString = [NSString stringWithFormat:@"%g\u00b0", newLocation.coordinate.longitude];
    self.longitudeLabel.text = longitudeString;
    
    NSString *horizontalAccuracyString = [NSString stringWithFormat:@"%gm", newLocation.horizontalAccuracy];
    self.horizantalAccuracyLabel.text = horizontalAccuracyString;
    
    NSString *altitudeString = [NSString stringWithFormat:@"%gm", newLocation.altitude];
    self.altitudeLabel.text = altitudeString;
    
    NSString *verticalAccuracyString = [NSString stringWithFormat:@"%gm", newLocation.verticalAccuracy];
    self.verticalAccuracyLabel.text = verticalAccuracyString;
    
    NSString *currentSpeedString = [NSString stringWithFormat:@"%gm/s", newLocation.speed];
    self.currentSpeedLabel.text = currentSpeedString;
    
    NSString *currentOrientationString = [NSString stringWithFormat:@"%g", newLocation.course];
    self.currentOrientationLabel.text = currentOrientationString;
//    if (newLocation.verticalAccuracy < 0 || newLocation.horizontalAccuracy < 0) {
//        //无效的精度
//        return;
//    }
//    if (newLocation.verticalAccuracy > 50 || newLocation.horizontalAccuracy > 100) {
//        //这里不使用过大的精度值
//        return;
//    }
    
    if (self.previousPoint == nil) {
        self.totalMovementDistance = 0;
        
        Place *start = [Place new];
        start.coordinate = newLocation.coordinate;
        start.titile = @"Start Point";
        start.subtitle = @"This is where we started!";
        
        [self.mapView addAnnotation:start];
        MKCoordinateRegion region;
        region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 100, 100);
        [self.mapView setRegion:region animated:YES];
    }else{
        self.totalMovementDistance += [newLocation distanceFromLocation:self.previousPoint];
    }
    self.previousPoint = newLocation;
    NSString *distanceString = [NSString stringWithFormat:@"%gm", [newLocation distanceFromLocation:self.previousPoint] ];
    self.distanceTraveledLabel.text = distanceString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
