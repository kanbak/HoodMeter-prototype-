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
#import "CustomAnnotations.h"

#define METERS_PER_MILE 1609.344

@interface CrimeMapViewController ()
{
    __weak IBOutlet MKMapView *crimeMapView;
}

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
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 41.87811;
    zoomLocation.longitude = -87.62980;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 2.0*METERS_PER_MILE, 2.0
                                                                       *METERS_PER_MILE);
    [crimeMapView setRegion:viewRegion animated:YES];
}
#pragma mark MKMapView Delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"MyLocation";
    if ([annotation isKindOfClass:[Crime class]])
{
        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[CustomAnnotations alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            
        } else {
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    
    return nil;
}


    


@end
