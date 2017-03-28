//
//  DeviceDetailViewController.h
//  Animal Age
//
//  Created by Jon on 3/27/17.
//  Copyright © 2017 Jon Brown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface DeviceDetailViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIBarPositioningDelegate, UINavigationBarDelegate>
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UITextField *date;
@property (weak, nonatomic) IBOutlet UITextField *pname;
@property (weak, nonatomic) IBOutlet UITextView *notes;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *choose;
@property (weak, nonatomic) IBOutlet UIButton *take;
@property (weak, nonatomic) IBOutlet UIButton *clear;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationbar;

@property (strong) NSManagedObject *device;

- (IBAction)Save:(id)sender;
- (IBAction)Cancel:(id)sender;
- (IBAction)selectPhoto:(id)sender;
- (IBAction)takePhoto:(id)sender;
- (IBAction)clearPhoto:(id)sender;
@end
