//
//  UISnapNav.m
//  Animal Age Converter
//
//  Created by Jon on 3/8/17.
//  Copyright © 2017 Jon Brown. All rights reserved.
//

#import "UISnapNav.h"

@interface UISnapNav ()

@end

@implementation UISnapNav

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationbar.delegate = self;
    
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init]
                                      forBarPosition:UIBarPositionAny
                                          barMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
    return UIBarPositionTopAttached;
}

@end
