//
//  Crime.h
//  HoodMeter(prototype)
//
//  Created by Umut Kanbak on 8/15/13.
//  Copyright (c) 2013 Umut Kanbak. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface Crime : NSObject <MKAnnotation>
@property (nonatomic, strong) NSNumber *arrestNumber;
@property (nonatomic, strong) NSString *beatString;
@property (nonatomic, strong) NSString *blockString;
@property (nonatomic, strong) NSString *caseNumberString;
@property (nonatomic, strong) NSNumber *communityAreaNumber;
@property (nonatomic, strong) NSDate *crimeDate;
@property (nonatomic, strong) NSString *crimeDescriptionString;
@property (nonatomic, strong) NSString *crimeDistrictString;
@property (nonatomic, strong) NSString *crimeDomesticString;
@property (nonatomic, strong) NSString *crimeFbiCodeString;
@property (nonatomic, strong) NSNumber *crimeIdNumber;
@property (nonatomic, strong) NSString *crimeIucrString;
@property (nonatomic, strong) NSNumber *latitudeNumber;
@property (nonatomic, strong) NSNumber *longitudeNumber;
@property (nonatomic, assign) CLLocationCoordinate2D crimeLocation;
@property (nonatomic, strong) NSString *locationDescriptionString;
@property (nonatomic, strong) NSString *primaryTypeString;
@property (nonatomic, strong) NSDate *crimeUpdateDate;
@property (nonatomic, strong) NSNumber *crimeYear;
@property (nonatomic, strong) NSString *crimeDateString;

-(instancetype)initWithCrimeDictionary:(NSDictionary *)crimeDictionary;

@end

/*
 arrest = 0;
 beat = 0825;
 block = "024XX W 62ND ST";
 "case_number" = HW399269;
 "community_area" = 66;
 date = "2013-08-07T05:00:00";
 description = "$500 AND UNDER";
 district = 008;
 domestic = 0;
 "fbi_code" = 06;
 id = 9254389;
 iucr = 0820;
 latitude = "41.78095259420785";
 location =     {
 latitude = "41.78095259420785";
 longitude = "-87.6851934933588";
 "needs_recoding" = 0;
 };
 "location_description" = APARTMENT;
 longitude = "-87.6851934933588";
 "primary_type" = THEFT;
 "updated_on" = "2013-08-11T00:42:01";
 ward = 15;
 "x_coordinate" = 1161026;
 "y_coordinate" = 1863436;
 year = 2013;
 */
