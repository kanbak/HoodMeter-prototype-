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

@property (nonatomic, strong) NSArray *crimesArray;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSURL *url=[NSURL URLWithString:@"http://data.cityofchicago.org/resource/a95h-gwzm.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
         NSMutableArray *temporaryArray = [NSMutableArray arrayWithCapacity:[jsonArray count]];
         [jsonArray enumerateObjectsUsingBlock:^(NSDictionary *crimeDictionary, NSUInteger idx, BOOL *stop) {
             Crime *crime = [[Crime alloc] initWithCrimeDictionary:crimeDictionary];
                         
             NSLog(@"%@", [crime description]);
             
             
             [temporaryArray addObject:crime];
         }];
         self.crimesArray = [NSArray arrayWithArray:temporaryArray];
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
