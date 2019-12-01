//
//  Calc.h
//  Animal Age Converter
//
//  Created by Jon Brown on 2/17/14.
//  Copyright (c) 2014 Jon Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ProgressHUD/ProgressHUD.h>

@interface Calc : NSObject {

    IBOutlet UITextField *PeopleString;
    IBOutlet UITextField *PeopleString2;
    IBOutlet UILabel *resultLabel;
    IBOutlet UIButton *BigCalc;
    IBOutlet UIButton *AnimalButt;
    IBOutlet UIButton *AnimalButt2;
    IBOutlet UIWebView *webView;
    IBOutlet UILabel *calcText;
    IBOutlet UIView *view;
    IBOutlet UIView *masterFlip;
    IBOutlet UIView *frontView;
    IBOutlet UIView *backView;
}
- (IBAction)calcTapped;
-(IBAction)showflip:(id)sender;

@property BOOL displayingFront;
@end
