//
//  CompassViewController.m
//  HoodMeter(prototype)
//
//  Created by Umut Kanbak on 8/20/13.
//  Copyright (c) 2013 Umut Kanbak. All rights reserved.
//

#import "CompassViewController.h"
#import "CoreDataManager.h"
#import "CrimeModel.h"

@interface CompassViewController ()
{
    CoreDataManager* coreDataManager;
    __weak IBOutlet UIView *caOutlet;
    __weak IBOutlet UIView *nwView;
    __weak IBOutlet UIView *neView;
    __weak IBOutlet UIView *swView;
    __weak IBOutlet UIView *seView;
    __weak IBOutlet UIView *currentLocationView;
}
@property (nonatomic, strong) NSArray *crimesArray;


@end

@implementation CompassViewController

@synthesize locationManager;
@synthesize compassViews;

- (void)viewDidLoad
{
    locationManager=[[CLLocationManager alloc] init];
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	locationManager.headingFilter = 1;
	locationManager.delegate=self;
	[locationManager startUpdatingHeading];
    
    [super viewDidLoad];
    
    coreDataManager = [[CoreDataManager alloc]init];
    
	// Do any additional setup after loading the view.
    NSMutableArray *nwArray = [NSMutableArray array];
    NSMutableArray *neArray = [NSMutableArray array];
    NSMutableArray *swArray = [NSMutableArray array];
    NSMutableArray *seArray = [NSMutableArray array];
    NSMutableArray *currentLocationRegionArray = [NSMutableArray array];
    
    NSURL *url=[NSURL URLWithString:@"http://data.cityofchicago.org/resource/a95h-gwzm.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
         
         //         for (NSDictionary *dictionary in jsonArray) {
         //             Crime *crime = [[Crime alloc] initWithCrimeDictionary:dictionary];
         //            [coreDataManager createCrimeObjectWithCrime:crime];
         //         }
         //NSMutableArray *temporaryArray = [NSMutableArray arrayWithCapacity:[jsonArray count]];
         [jsonArray enumerateObjectsUsingBlock:^(NSDictionary *crimeDictionary, NSUInteger idx, BOOL *stop) {
             if ([crimeDictionary valueForKey:@"location"]) {
                 Crime *crime = [[Crime alloc] initWithCrimeDictionary:crimeDictionary];
                 [coreDataManager createCrimeObjectWithCrime:crime];
             }
             
             //[temporaryArray addObject:crime];
         }];
         self.crimesArray = [coreDataManager getArrayOfCrimes];
         CLLocationCoordinate2D currentLocation = locationManager.location.coordinate;
         CLLocationDistance regionRadius = 2000.00;
         CLRegion *currentLocationRegion = [[CLRegion alloc]initCircularRegionWithCenter:locationManager.location.coordinate radius:regionRadius identifier:@"currentLocationRegion"];
         int currentLocationRegionCrimeVolumeCount;
         
         for (CrimeModel *crime in self.crimesArray){
             CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([crime.crimeLatitude doubleValue], [crime.crimeLongitude doubleValue]);
             if ([currentLocationRegion containsCoordinate:coordinate]){
                 [currentLocationRegionArray addObject:crime];
                 currentLocationRegionCrimeVolumeCount= currentLocationRegionArray.count;
                 
             }
             
             
         }
         
         for (CrimeModel *crime in self.crimesArray) {
             if (([crime.crimeLatitude doubleValue] <= currentLocation.latitude)&&([crime.crimeLongitude doubleValue] >= currentLocation.longitude)) {
                 [nwArray addObject:crime];
             }
             else if (([crime.crimeLatitude doubleValue] >= currentLocation.latitude)&&([crime.crimeLongitude doubleValue] >= currentLocation.longitude)) {
                 [neArray addObject:crime];
             }
             else if (([crime.crimeLatitude doubleValue] <= currentLocation.latitude)&&([crime.crimeLongitude doubleValue] <= currentLocation.longitude)) {
                 [swArray addObject:crime];
             }
             else if (([crime.crimeLatitude doubleValue] >= currentLocation.latitude)&&([crime.crimeLongitude doubleValue] <= currentLocation.longitude)) {
                 [seArray addObject:crime];
             }
             //NSLog(@"NW:%i NE:%i SW:%i SE:%i",[nwArray count],[neArray count], [swArray count], [seArray count])
             
             
         }
         int nwCrimeVolume = nwArray.count;
         NSLog(@"NW %i",nwCrimeVolume);
         int neCrimeVolume = neArray.count;
         NSLog(@"NE %i",neCrimeVolume);
         int swCrimeVolume = swArray.count;
         NSLog(@"SW %i",swCrimeVolume);
         int seCrimeVolume = seArray.count;
         NSLog(@"SE %i",seCrimeVolume);
         
         if (nwCrimeVolume <=100) {
             nwView.backgroundColor = [UIColor greenColor];}
         else if
             (nwCrimeVolume >=100 && nwCrimeVolume <=299){
                 nwView.backgroundColor = [UIColor yellowColor];}
         else if
             (nwCrimeVolume >=300 && nwCrimeVolume <=599){
                 nwView.backgroundColor = [UIColor orangeColor];}
         else if
             (nwCrimeVolume >=600){
                 nwView.backgroundColor = [UIColor redColor];}
         if (neCrimeVolume <=100) {
             neView.backgroundColor = [UIColor greenColor];}
         else if
             (neCrimeVolume >=100 && neCrimeVolume <=299){
                 neView.backgroundColor = [UIColor yellowColor];}
         else if
             (neCrimeVolume >=300 && neCrimeVolume <=599){
                 neView.backgroundColor = [UIColor orangeColor];}
         else if
             (neCrimeVolume >=600){
                 neView.backgroundColor = [UIColor redColor];}
         if (swCrimeVolume <=100) {
             swView.backgroundColor = [UIColor greenColor];}
         else if
             (swCrimeVolume >=100 && swCrimeVolume <=299){
                 swView.backgroundColor = [UIColor yellowColor];}
         else if
             (swCrimeVolume >=300 && swCrimeVolume <=599){
                 swView.backgroundColor = [UIColor orangeColor];}
         else if
             (swCrimeVolume >=600){
                 swView.backgroundColor = [UIColor redColor];}
         if (seCrimeVolume <=100) {
             seView.backgroundColor = [UIColor greenColor];}
         else if
             (seCrimeVolume >=100 && seCrimeVolume <=299){
                 seView.backgroundColor = [UIColor yellowColor];}
         else if
             (seCrimeVolume >=300 && seCrimeVolume <=599){
                 seView.backgroundColor = [UIColor orangeColor];}
         else if
             (seCrimeVolume >=600){
                 seView.backgroundColor = [UIColor redColor];}
         if (currentLocationRegionCrimeVolumeCount <=100) {
             currentLocationView.backgroundColor = [UIColor greenColor];}
         else if
             (currentLocationRegionCrimeVolumeCount >=100 && currentLocationRegionCrimeVolumeCount <=299){
                 currentLocationView.backgroundColor = [UIColor yellowColor];}
         else if
             (currentLocationRegionCrimeVolumeCount >=300 && currentLocationRegionCrimeVolumeCount <=599){
                 currentLocationView.backgroundColor = [UIColor orangeColor];}
         else if
             (currentLocationRegionCrimeVolumeCount >=600){
                 currentLocationView.backgroundColor = [UIColor redColor];}
         
         
         
     }];
    
}


- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
	// Convert Degree to Radian and move the needle
	float oldRad =  -manager.heading.trueHeading * M_PI / 180.0f;
	float newRad =  -newHeading.trueHeading * M_PI / 180.0f;
	CABasicAnimation *theAnimation;
	theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation"];
	theAnimation.fromValue = [NSNumber numberWithFloat:oldRad];
	theAnimation.toValue=[NSNumber numberWithFloat:newRad];
	theAnimation.duration = 0.5f;
	[caOutlet.layer addAnimation:theAnimation forKey:@"animateMyRotation"];
	caOutlet.transform = CGAffineTransformMakeRotation(newRad);
	NSLog(@"%f (%f) => %f (%f)", manager.heading.trueHeading, oldRad, newHeading.trueHeading, newRad);
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
