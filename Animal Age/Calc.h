//
//  Calc.h
//  Animal Age
//
//  Created by Jon Brown on 2/17/14.
//  Copyright (c) 2014 Jon Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProgressHUD.h"

@interface Calc : NSObject {

    IBOutlet UITextField *PeopleString;
    IBOutlet UILabel *resultLabel;
    IBOutlet UIButton *BigCalc;
    IBOutlet UIButton *AnimalButt;
    IBOutlet UIWebView *webView;
    IBOutlet UILabel *calcText;
    IBOutlet UIView *view;
}
- (IBAction)calcTapped;
@end
