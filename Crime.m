//
//  Crime.m
//  HoodMeter(prototype)
//
//  Created by Umut Kanbak on 8/15/13.
//  Copyright (c) 2013 Umut Kanbak. All rights reserved.
//

#import "Crime.h"

@implementation Crime


-(instancetype)initWithCrimeDictionary:(NSDictionary *)crimeDictionary{
    self = [super init];
    if (self){
        _arrestNumber = [crimeDictionary valueForKey:@"arrest"];
        _beatString = [crimeDictionary valueForKey:@"beat"];
        _blockString =[crimeDictionary valueForKey:@"block"];
        _caseNumberString =[crimeDictionary valueForKey:@"case_number"];
        _communityAreaNumber =[crimeDictionary valueForKey:@"community_area"];
        
        NSDateFormatter *newFormatter = [NSDateFormatter new];
        [newFormatter setDateFormat:@"yyyy-MM-ddTHH:mm:ss"];
        NSString *dateString = [crimeDictionary valueForKey:@"date"];
        _crimeDateString = dateString;
        _crimeDate = [newFormatter dateFromString:dateString];
        _crimeDescriptionString = [crimeDictionary valueForKey:@"description"];
        _crimeDistrictString = [crimeDictionary valueForKey:@"district"];
        _crimeDomesticString = [crimeDictionary valueForKey:@"domestic"];
        _crimeFbiCodeString = [crimeDictionary valueForKey:@"fbi_code"];
        _crimeIdNumber = [crimeDictionary valueForKey:@"id"];
        _crimeIucrString = [crimeDictionary valueForKey:@"iucr"];
        _latitudeNumber = [crimeDictionary valueForKey:@"latitude"];
        _longitudeNumber = [crimeDictionary valueForKey:@"longitude"];
        _crimeLocation = CLLocationCoordinate2DMake([_latitudeNumber floatValue], [_longitudeNumber floatValue]);
        _locationDescriptionString = [crimeDictionary valueForKey:@"location_description"];
        _primaryTypeString = [crimeDictionary valueForKey:@"primary_type"];
        _crimeUpdateDate = [crimeDictionary valueForKey:@"updated_on"];
        _crimeYear = [crimeDictionary valueForKey:@"year"];
    }
    return self;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"%@ %@ %@ %f%f", self.blockString, self.primaryTypeString,self.crimeDescriptionString, self.crimeLocation.latitude, self.crimeLocation.longitude];
}

-(CLLocationCoordinate2D)coordinate {
    return self.crimeLocation;
}

-(NSString *)title {
    return self.primaryTypeString;
}

-(NSString *)subtitle {
    return self.crimeDescriptionString;
}

@end 
