//
//  AnimalPicker.h
//  Animal Age
//
//  Created by Jon Brown on 2/17/14.
//  Copyright (c) 2014 Jon Brown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "PickerTableView.h"
#import "Calc.h"
#import "RFRateMe.h"

@interface AnimalPicker : UIViewController <AnimalPickerControllerDelegate, UIActionSheetDelegate, UITextFieldDelegate>
{

    IBOutlet UIView *mainArea;
    IBOutlet UIWebView *graphView;
    IBOutlet UIButton *AnimalButt;
    IBOutlet UIButton *AnimalButt2;
    IBOutlet UIButton *AgeButt;
    IBOutlet UIButton *convertButt;
    IBOutlet UITextField *HumanAge;
    IBOutlet UITextField *HumanAge2;
    IBOutlet UIView *ManView;
    IBOutlet UIView *ManView2;
    IBOutlet UILabel *calcText;
    IBOutlet UILabel *resultLabel;
    IBOutlet UIWebView *webView;
    IBOutlet UIView *backView;
    IBOutlet UIView *frontView;
    IBOutlet UIView *masterFlip;
}

@property(nonatomic, strong) UITableViewController *SimpleTableVC;

@end
