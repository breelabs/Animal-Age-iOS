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
    CGContextSetRGBFillColor(context, 0.679, 0.679, 0.679, 1.0);
    
    // draw the filled rectangle
    CGContextFillRect (context, self.bounds);
    
    CALayer *bottomBorder = [CALayer layer];
    
    bottomBorder.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, 1.0f);
    
    bottomBorder.backgroundColor = [UIColor colorWithWhite:0.8f
                                                     alpha:1.0f].CGColor;
    
    [self.layer addSublayer:bottomBorder];
}

@end
