//
//  CoreDataManager.m
//  HoodMeter(prototype)
//
//  Created by Umut Kanbak on 8/20/13.
//  Copyright (c) 2013 Umut Kanbak. All rights reserved.
//

#import "CoreDataManager.h"
#import "AppDelegate.h"
#import "Crime.h"

@implementation CoreDataManager
{
    NSManagedObjectContext *context;
    
}

-(instancetype)init
{
    self = [super init];
    if (self){
        context = ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
    }
    return self;
}
-(void)saveData
{
    NSError *error;
    if (![context save:&error])
    {
        NSLog(@"failed to save error: %@", [error userInfo]);
    }
}
               
-(CrimeModel *)createCrimeObjectWithCrime:(Crime *)crime
{
    CrimeModel *crimeModel = [NSEntityDescription insertNewObjectForEntityForName:@"CrimeModel" inManagedObjectContext:context];
    crimeModel.crimeLatitude = [crime latitudeNumber];
    crimeModel.crimeLongitude = [crime longitudeNumber];
    //crimeModel.crimeYear = [crime crimeYear];
    crimeModel.crimeDescriptionString = [crime crimeDescriptionString];
    crimeModel.crimeDate = [crime crimeDate];

    [self saveData];
    return crimeModel;
}
-(NSArray*) getArrayOfCrimes
{
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CrimeModel" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedObjects;
    
    
}
@end
