//
//  DetailViewController.h
//  HoodMeter(prototype)
//
//  Created by Umut Kanbak on 8/22/13.
//  Copyright (c) 2013 Umut Kanbak. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Crime.h"
@class Crime;

@interface DetailViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>

@property (nonatomic, strong)Crime *crime;

@end
