//
//  Compass.h
//  HoodMeter(prototype)
//
//  Created by Joel on 8/16/13.
//  Copyright (c) 2013 Umut Kanbak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>

@interface Compass : UIViewController <CLLocationManagerDelegate>
{
    __weak IBOutlet UIImageView *compassImage;
    
}

@property (nonatomic, retain) CLLocationManager *locationManager;


@end
CLLocationManager *LocationManager;