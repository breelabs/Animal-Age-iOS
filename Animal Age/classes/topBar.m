//
//  topBar.m
//  Animal Age
//
//  Created by Jon Brown on 2/16/14.
//  Copyright (c) 2014 Jon Brown. All rights reserved.
//

#import "topBar.h"

@implementation topBar


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext ();
    
    // The color to fill the rectangle (in this case black)
    CGContextSetRGBFillColor(context, 0.96, 0.84, 0.09, 1.0);
    // draw the filled rectangle
    CGContextFillRect (context, self.bounds);
}

@end
