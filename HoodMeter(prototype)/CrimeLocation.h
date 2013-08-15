//
//  CrimeLocation.h
//  HoodMeter(prototype)
//
//  Created by Umut Kanbak on 8/15/13.
//  Copyright (c) 2013 Umut Kanbak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CrimeLocation : NSObject <MKAnnotation>

@property(strong, nonatomic) NSString *title;
@property(strong,nonatomic) NSString *description;
@property(assign, nonatomic) CLLocationCoordinate2D coordinate;


@end
