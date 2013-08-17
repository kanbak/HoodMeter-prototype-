//
//  CustomAnnotations.m
//  HoodMeter(prototype)
//
//  Created by Joel on 8/17/13.
//  Copyright (c) 2013 Umut Kanbak. All rights reserved.
//

#import "CustomAnnotations.h"

@implementation CustomAnnotations

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.image = [UIImage imageNamed:@"narcoticsIcon2.png"];
        
    }
    return self;
}

@end
