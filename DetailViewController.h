//
//  DetailViewController.h
//  HoodMeter(prototype)
//
//  Created by Umut Kanbak on 8/22/13.
//  Copyright (c) 2013 Umut Kanbak. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Crime.h"
@class Crime;

@interface DetailViewController : UIViewController 

@property (nonatomic, strong)Crime *crime;

@end
