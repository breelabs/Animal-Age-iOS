//
//  subBar.m
//  Animal Age
//
//  Created by Jon Brown on 2/20/14.
//  Copyright (c) 2014 Jon Brown. All rights reserved.
//

#import "subBar.h"

@implementation subBar

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext ();
    
    // The color to fill the rectangle (in this case black)
    CGContextSetRGBFillColor(context, 0.96, 0.84, 0.09, 1.0);
    
    // draw the filled rectangle
    CGContextFillRect (context, self.bounds);
    
    CALayer *bottomBorder = [CALayer layer];
    
    bottomBorder.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, 1.0f);
    
    bottomBorder.backgroundColor = [UIColor whiteColor].CGColor;
    
    [self.layer addSublayer:bottomBorder];
}

@end
