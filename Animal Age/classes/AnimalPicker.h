//
//  AnimalPicker.h
//  Animal Age Converter
//
//  Created by Jon Brown on 2/17/14.
//  Copyright (c) 2014 Jon Brown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreData/CoreData.h>
#import "PickerTableView.h"
#import "Calc.h"
#import "ProgressHUD.h"

@interface AnimalPicker : UIViewController <AnimalPickerControllerDelegate, UIActionSheetDelegate, UITextFieldDelegate, UIBarPositioningDelegate, UINavigationBarDelegate>
{

    IBOutlet UIView *mainArea;
    IBOutlet UIWebView *graphView;
    IBOutlet UIButton *AnimalButt;
    IBOutlet UIButton *AnimalButt2;
    IBOutlet UIButton *AgeButt;
    IBOutlet UIButton *AddButt;
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
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationbar;
@property(nonatomic, strong) UITableViewController *SimpleTableVC;
- (IBAction)save:(id)sender;
@end
