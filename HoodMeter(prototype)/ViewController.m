//
//  ViewController.m
//  HoodMeter(prototype)
//
//  Created by Umut Kanbak on 8/14/13.
//  Copyright (c) 2013 Umut Kanbak. All rights reserved.
//
//just typing something to test git......!!!!!!!!!!!!!!!!!

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    NSURL *url=[NSURL URLWithString:@"http://data.cityofchicago.org/resource/a95h-gwzm.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [super viewDidLoad];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
         NSMutableString *responseString;
         responseString=[[NSMutableString alloc]init];
         
         [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
             NSDictionary *jsonDictionary = (NSDictionary *)obj;
             NSString *description = [jsonDictionary objectForKey:@"description"];
             NSString *latitude = [jsonDictionary objectForKey:@"latitude"];
             NSString *longitude = [jsonDictionary objectForKey:@"longitude"];
             NSString *primaryType = [jsonDictionary objectForKey:@"primary_type"];
             
             NSLog(@"Type: %@\nDescription: %@\nLatitude: %@\nLongitude: %@\n\n",primaryType, description, latitude, longitude);
             
             [responseString appendFormat:@"Type: %@\nDescription: %@\nLatitude: %@\nLongitude: %@\n\n",primaryType, description, latitude, longitude];
             
         }];
     }];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//hello
//hello back!!!!!
@end
