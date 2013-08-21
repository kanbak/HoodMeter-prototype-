//
//  HoodMeter(prototype).h
//  HoodMeter(prototype)
//
//  Created by Umut Kanbak on 8/20/13.
//  Copyright (c) 2013 Umut Kanbak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CrimeModel : NSManagedObject

@property (nonatomic, retain) NSString * crimeDescriptionString;
@property (nonatomic, retain) NSDate * crimeDate;
@property (nonatomic, retain) NSNumber * crimeLatitude;
@property (nonatomic, retain) NSNumber * crimeLongitude;
@property (nonatomic, retain) NSString * primaryTypeString;
@property (nonatomic, retain) NSString * locationDescriptionString;
@property (nonatomic, retain) NSNumber * crimeYear;

@end
