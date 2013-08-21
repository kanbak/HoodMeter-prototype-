//
//  CoreDataManager.h
//  HoodMeter(prototype)
//
//  Created by Umut Kanbak on 8/20/13.
//  Copyright (c) 2013 Umut Kanbak. All rights reserved.
//

@class Crime;
#import <Foundation/Foundation.h>
#import "CrimeModel.h"

@interface CoreDataManager : NSObject

-(CrimeModel *)createCrimeObjectWithCrime:(Crime *)crime;
-(NSArray*) getArrayOfCrimes;

@end
