//
//  ZSLocationManager.m
//  MyTestDemo
//
//  Created by zhaosheng on 2019/8/20.
//  Copyright © 2019 zs. All rights reserved.
//

#import "ZSLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface ZSLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic) CLLocationManager *locationManager;

@end

@implementation ZSLocationManager

- (void)startUpdatingLocation
{
    [self.locationManager requestWhenInUseAuthorization];
}

- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    }
    return _locationManager;
}

@end
