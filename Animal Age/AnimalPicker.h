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

@interface AnimalPicker : UIViewController <AnimalPickerControllerDelegate, UIActionSheetDelegate, UITextFieldDelegate>
{

    IBOutlet UIView *mainArea;
    IBOutlet UIWebView *graphView;
    IBOutlet UIButton *AnimalButt;
    IBOutlet UIButton *AgeButt;
    IBOutlet UIButton *convertButt;
    IBOutlet UITextField *HumanAge;
    IBOutlet UIView *ManView;
    IBOutlet UIView *bottomView;
    IBOutlet UILabel *calcText;
    IBOutlet UILabel *resultLabel;
    
    IBOutlet UITextField *PeopleString;
    IBOutlet UIWebView *webView;
}

@end
