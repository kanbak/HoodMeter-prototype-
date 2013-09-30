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

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property(assign, nonatomic) CLLocationCoordinate2D coordinate;


@end
