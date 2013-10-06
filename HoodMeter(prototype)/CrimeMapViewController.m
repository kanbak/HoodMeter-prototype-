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
#import "DetailViewController.h"

#define METERS_PER_MILE 1609.344

@interface CrimeMapViewController ()
{
    __weak IBOutlet MKMapView *crimeMapView;
    __weak IBOutlet UISearchBar *searchBar;
    BOOL updatedLocation;
    
}
- (IBAction)showSearchBar:(id)sender;
- (IBAction)locateMeAndZoom:(id)sender;


@property (nonatomic, strong) NSArray *crimesArray;

@end

@implementation CrimeMapViewController

-(void)loadCrimesArray:(NSArray*)crimesArray{
    self.crimesArray = crimesArray;
    
}

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
    searchBar.hidden = YES;
    
    [crimeMapView addAnnotations:self.crimesArray];
    updatedLocation = NO;
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    crimeMapView.showsUserLocation = YES;
}
#pragma mark MKMapView Delegate

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    if (updatedLocation == NO){
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 2.0*METERS_PER_MILE, 2.0
                                                                           *METERS_PER_MILE);
        [crimeMapView setRegion:viewRegion animated:YES];
        updatedLocation = YES;
    }
   
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"MyLocation";
    if ([annotation isKindOfClass:[Crime class]]) {
        Crime *crimeAnnotation = (Crime *)annotation;
        MKAnnotationView *annotationView = (MKAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:crimeAnnotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];            
        } else {
            annotationView.annotation = annotation;
        }
        
        annotationView.image = [UIImage imageNamed:crimeAnnotation.primaryTypeString];
        annotationView.frame = CGRectMake(annotationView.frame.origin.x,
                                          annotationView.frame.origin.y,
                                          annotationView.image.size.width,
                                          annotationView.image.size.height);
        
        return annotationView;
    }
    
    return nil;
    
    mapView.showsUserLocation = YES;
    
}
-(void)searchBarSearchButtonClicked:(UISearchBar*)aSearchBar
{
    [aSearchBar resignFirstResponder];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:aSearchBar.text completionHandler:^(NSArray *placemarks, NSError *error) {
        //Error checking
        
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        MKCoordinateRegion region;
        region.center = [(CLCircularRegion *)placemark.region center];
       // region.center.latitude = placemark.region.center.latitude; deprecated in iOS7
       // region.center.longitude = placemark.region.center.longitude; deprecated in iOS7
        MKCoordinateSpan span;
       // double radius = placemark.region.radius / 1000; // convert to km deprecated in iOS7
        
      //  NSLog(@"[searchBarSearchButtonClicked] Radius is %f", radius); deprecated in iOS7
        //span.latitudeDelta = radius / 20.0;
        span.latitudeDelta = 0.01;
        span.longitudeDelta = 0.01;
        
        region.span = span;
        
        [crimeMapView setRegion:region animated:YES];
        aSearchBar.hidden = YES;
    }];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)aSearchBar{
    [aSearchBar resignFirstResponder];
    aSearchBar.hidden = YES;
    
}
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    
    Crime *selectedCrime = (Crime *) view.annotation;
    DetailViewController *detailViewController;
    [self performSegueWithIdentifier:@"toDetailView" sender:self];
    detailViewController = (DetailViewController *) [self.navigationController.viewControllers lastObject];
    detailViewController.crime=selectedCrime;
    
}
- (IBAction)showSearchBar:(id)sender {
    searchBar.hidden = NO;
    [searchBar becomeFirstResponder];
    
}

- (IBAction)locateMeAndZoom:(id)sender {
    CLLocationManager *locationManager = [CLLocationManager new];
    MKCoordinateSpan span=MKCoordinateSpanMake(0.0050, 0.0050);
    MKCoordinateRegion aRegion=MKCoordinateRegionMake(locationManager.location.coordinate, span);
    [crimeMapView setRegion:aRegion animated:YES];
}
@end
