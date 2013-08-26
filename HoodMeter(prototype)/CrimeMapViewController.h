//
//  CrimeMapViewController.h
//  HoodMeter(prototype)
//
//  Created by Umut Kanbak on 8/15/13.
//  Copyright (c) 2013 Umut Kanbak. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CrimeMapViewController : ViewController <CLLocationManagerDelegate, MKMapViewDelegate>

-(void)loadCrimesArray:(NSArray*)crimesArray;

@end
