//
//  DetailViewController.m
//  HoodMeter(prototype)
//
//  Created by Umut Kanbak on 8/22/13.
//  Copyright (c) 2013 Umut Kanbak. All rights reserved.
//

#import "DetailViewController.h"
#import "Crime.h"

#define METERS_PER_MILE 1609.344

@interface DetailViewController ()
{
    __weak IBOutlet UILabel *crimeTypeOutlet;
    __weak IBOutlet UILabel *crimeDescOutlet;
    __weak IBOutlet UILabel *crimeDateOutlet;
    __weak IBOutlet UILabel *crimeLocationOutlet;
    __weak IBOutlet UILabel *crimeLatitudeOutlet;
    __weak IBOutlet UILabel *crimeLongitudeOutlet;
    NSString *crimeLatitude;
    NSString *crimeLongitude;

    __weak IBOutlet MKMapView *detailViewMapViewOutlet;
}

@end

@implementation DetailViewController
@synthesize crime;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    crimeLatitude = [[NSNumber numberWithDouble:crime.coordinate.latitude] stringValue];
    crimeLongitude = [[NSNumber numberWithDouble:crime.coordinate.longitude] stringValue];
    
    self.navigationItem.title = self.crime.primaryTypeString;
    crimeTypeOutlet.text = crime.primaryTypeString;
    crimeDescOutlet.text = crime.crimeDescriptionString;
    crimeDateOutlet.text = crime.crimeDateString;
    crimeLocationOutlet.text = crime.blockString;
    crimeLatitudeOutlet.text = crimeLatitude;
    crimeLongitudeOutlet.text = crimeLongitude;
    NSLog(@"%@", crime.primaryTypeString);
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.0050, 0.0050);
    MKCoordinateRegion aRegion = MKCoordinateRegionMake(crime.coordinate, span);
    [detailViewMapViewOutlet setRegion:aRegion animated:NO];
    [detailViewMapViewOutlet addAnnotation:crime];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"MyLocation";
    if ([annotation isKindOfClass:[Crime class]]) {
        Crime *crimeAnnotation = (Crime *)annotation;
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:crimeAnnotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.pinColor = MKPinAnnotationColorPurple;
            
        } else {
            annotationView.annotation = annotation;
        }

        return annotationView;
    }
    
    return nil;
    
    mapView.showsUserLocation = YES;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
