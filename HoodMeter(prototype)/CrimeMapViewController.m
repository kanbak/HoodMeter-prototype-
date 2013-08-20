//
//  CrimeMapViewController.m
//  HoodMeter(prototype)
//
//  Created by Umut Kanbak on 8/15/13.
//  Copyright (c) 2013 Umut Kanbak. All rights reserved.
//

#import "CrimeMapViewController.h"
#import "MapKit/MapKit.h"
#import <CoreLocation/CoreLocation.h>
#import "CrimeLocation.h"
#import "Crime.h"

#define METERS_PER_MILE 1609.344

@interface CrimeMapViewController ()
{
    __weak IBOutlet MKMapView *crimeMapView;
    __weak IBOutlet UISearchBar *searchBar;
    CLLocationManager *locationManager;
    __weak IBOutlet UIView *nwView;
    __weak IBOutlet UIView *neView;
    __weak IBOutlet UIView *swView;
    __weak IBOutlet UIView *seView;
    
}
- (IBAction)showSearchBar:(id)sender;

@property (nonatomic, strong) NSArray *crimesArray;

@end

@implementation CrimeMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    NSMutableArray *nwArray = [NSMutableArray array];
    NSMutableArray *neArray = [NSMutableArray array];
    NSMutableArray *swArray = [NSMutableArray array];
    NSMutableArray *seArray = [NSMutableArray array];

    NSURL *url=[NSURL URLWithString:@"http://data.cityofchicago.org/resource/a95h-gwzm.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
         NSMutableArray *temporaryArray = [NSMutableArray arrayWithCapacity:[jsonArray count]];
         [jsonArray enumerateObjectsUsingBlock:^(NSDictionary *crimeDictionary, NSUInteger idx, BOOL *stop) {
             Crime *crime = [[Crime alloc] initWithCrimeDictionary:crimeDictionary];
             
             [temporaryArray addObject:crime];
         }];
         self.crimesArray = [NSArray arrayWithArray:temporaryArray];
         [crimeMapView addAnnotations:self.crimesArray];
         
         CLLocationCoordinate2D currentLocation = locationManager.location.coordinate;
         
         for (Crime *crime in self.crimesArray) {
             if ((crime.coordinate.latitude <= locationManager.location.coordinate.latitude)&&(crime.coordinate.longitude >= currentLocation.longitude)) {
                 [nwArray addObject:crime];
             }
             else if ((crime.coordinate.latitude >= locationManager.location.coordinate.latitude)&&(crime.coordinate.longitude >= locationManager.location.coordinate.longitude)) {
                 [neArray addObject:crime];
             }
             else if ((crime.coordinate.latitude <= locationManager.location.coordinate.latitude)&&(crime.coordinate.longitude <= locationManager.location.coordinate.longitude)) {
                 [swArray addObject:crime];
             }
             else if ((crime.coordinate.latitude >= locationManager.location.coordinate.latitude)&&(crime.coordinate.longitude <= locationManager.location.coordinate.longitude)) {
                 [seArray addObject:crime];
             }
         //NSLog(@"NW:%i NE:%i SW:%i SE:%i",[nwArray count],[neArray count], [swArray count], [seArray count]);
         
        
         
         }
     int nwCrimeVolume = nwArray.count;
     NSLog(@"%i",nwCrimeVolume);
     int neCrimeVolume = neArray.count;
     NSLog(@"%i",neCrimeVolume);
     int swCrimeVolume = swArray.count;
     NSLog(@"%i",swCrimeVolume);
     int seCrimeVolume = seArray.count;
     NSLog(@"%i",seCrimeVolume);
         
         if (nwCrimeVolume <=100) {
             nwView.backgroundColor = [UIColor greenColor];}

         else if
             (nwCrimeVolume >=100 && nwCrimeVolume <=299){
                 nwView.backgroundColor = [UIColor yellowColor];}
             else if
                 (nwCrimeVolume >=300 && nwCrimeVolume <=599){
                     nwView.backgroundColor = [UIColor orangeColor];}
                 else if
                     (nwCrimeVolume >=600 && nwCrimeVolume <=10000){
                         nwView.backgroundColor = [UIColor redColor];}
                     
         if (nwCrimeVolume <=100) {
             neView.backgroundColor = [UIColor greenColor];}
         
         else if
             (neCrimeVolume >=100 && nwCrimeVolume <=299){
                 neView.backgroundColor = [UIColor yellowColor];}
         else if
             (neCrimeVolume >=300 && nwCrimeVolume <=599){
                 neView.backgroundColor = [UIColor orangeColor];}
         else if
             (neCrimeVolume >=600 && nwCrimeVolume <=10000){
                 neView.backgroundColor = [UIColor redColor];}
         
         if (swCrimeVolume <=100) {
             swView.backgroundColor = [UIColor greenColor];}
         
         else if
             (swCrimeVolume >=100 && nwCrimeVolume <=299){
                 swView.backgroundColor = [UIColor yellowColor];}
         else if
             (swCrimeVolume >=300 && nwCrimeVolume <=599){
                 swView.backgroundColor = [UIColor orangeColor];}
         else if
             (swCrimeVolume >=600 && nwCrimeVolume <=10000){
                 swView.backgroundColor = [UIColor redColor];}
         
         if (seCrimeVolume <=100) {
             seView.backgroundColor = [UIColor greenColor];}
         
         else if
             (seCrimeVolume >=100 && nwCrimeVolume <=299){
                 seView.backgroundColor = [UIColor yellowColor];}
         else if
             (seCrimeVolume >=300 && nwCrimeVolume <=599){
                 seView.backgroundColor = [UIColor orangeColor];}
         else if
             (seCrimeVolume >=600 && nwCrimeVolume <=10000){
                 seView.backgroundColor = [UIColor redColor];}
         
     }];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
//    CLLocationCoordinate2D zoomLocation;
//    zoomLocation.latitude = 41.8856;
//    zoomLocation.longitude = -87.6522;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(locationManager.location.coordinate, 2.0*METERS_PER_MILE, 2.0
                                                                       *METERS_PER_MILE);
    [crimeMapView setRegion:viewRegion animated:YES];
}
#pragma mark MKMapView Delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"MyLocation";
    if ([annotation isKindOfClass:[Crime class]]) {
        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
        } else {
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    
    return nil;
}
-(void)searchBarSearchButtonClicked:(UISearchBar*)aSearchBar
{
    [aSearchBar resignFirstResponder];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:aSearchBar.text completionHandler:^(NSArray *placemarks, NSError *error) {
        //Error checking
        
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        MKCoordinateRegion region;
        region.center.latitude = placemark.region.center.latitude;
        region.center.longitude = placemark.region.center.longitude;
        MKCoordinateSpan span;
        double radius = placemark.region.radius / 1000; // convert to km
        
        NSLog(@"[searchBarSearchButtonClicked] Radius is %f", radius);
        span.latitudeDelta = radius / 20.0;
        
        region.span = span;
        
        [crimeMapView setRegion:region animated:YES];
        aSearchBar.hidden = YES;
    }];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)aSearchBar{
    [aSearchBar resignFirstResponder];
    aSearchBar.hidden = YES;

}




- (IBAction)showSearchBar:(id)sender {
    searchBar.hidden = NO;
}
@end
