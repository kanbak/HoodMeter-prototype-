//
//  DetailViewController.m
//  HoodMeter(prototype)
//
//  Created by Umut Kanbak on 8/22/13.
//  Copyright (c) 2013 Umut Kanbak. All rights reserved.
//

#import "DetailViewController.h"
#import "Crime.h"

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
