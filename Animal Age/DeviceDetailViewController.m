//
//  DeviceDetailViewController.m
//  Animal Age Converter
//
//  Created by Jon on 3/27/17.
//  Copyright © 2017 Jon Brown. All rights reserved.
//

#import "DeviceDetailViewController.h"
#import "AppDelegate.h"


@interface DeviceDetailViewController ()

@end

@implementation DeviceDetailViewController
@synthesize device;


-(NSManagedObjectContext *)managedObjectContext{
    
    NSManagedObjectContext *context = nil;
    id delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    // call "persistentContainer" not "managedObjectContext"
    if( [delegate performSelector:@selector(persistentContainer)] ){
        // call viewContext from persistentContainer not "managedObjectContext"
        context = [[delegate persistentContainer] viewContext];
    }
    
    return context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationbar.delegate = self;
    
    if (self.device) {
        [self.name setText:[self.device valueForKey:@"name"]];
        [self.date setText:[self.device valueForKey:@"date"]];
        [self.age setText:[self.device valueForKey:@"age"]];
        [self.pname setText:[self.device valueForKey:@"pet_name"]];
        [self.notes setText:[self.device valueForKey:@"notes"]];
        
        UIImage *image = [UIImage imageWithData:[self.device valueForKey:@"img"]];
        [self.imageView setImage:image];
        
    }
    
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [datePicker setDate:[NSDate date]];
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.date setInputView:datePicker];
    
    
    // R: 76 G: 76 B: 76
   // UIColor *buttColor = [UIColor whiteColor];
    // UIColor *butbackcolor = [UIColor clearColor];
    UIColor *grey = [UIColor colorWithRed:0.74 green:0.76 blue:0.78 alpha:1.0];
    
    CALayer * layer = [_notes layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:4.0]; //when radius is 0, the border is a rectangle
    [layer setBorderWidth:1.0];
    [layer setBorderColor:[grey CGColor]];
    
    CALayer * layer2 = [_age layer];
    [layer2 setMasksToBounds:YES];
    [layer2 setCornerRadius:4.0]; //when radius is 0, the border is a rectangle
    [layer2 setBorderWidth:1.0];
    [layer2 setBorderColor:[grey CGColor]];
    
    CALayer * layer3 = [_name layer];
    [layer3 setMasksToBounds:YES];
    [layer3 setCornerRadius:4.0]; //when radius is 0, the border is a rectangle
    [layer3 setBorderWidth:1.0];
    [layer3 setBorderColor:[grey CGColor]];
    
    CALayer * layer4 = [_pname layer];
    [layer4 setMasksToBounds:YES];
    [layer4 setCornerRadius:4.0]; //when radius is 0, the border is a rectangle
    [layer4 setBorderWidth:1.0];
    [layer4 setBorderColor:[grey CGColor]];
    
    
    CALayer * layer5 = [_date layer];
    [layer5 setMasksToBounds:YES];
    [layer5 setCornerRadius:4.0]; //when radius is 0, the border is a rectangle
    [layer5 setBorderWidth:1.0];
    [layer5 setBorderColor:[grey CGColor]];
    
    CALayer * layer6 = [_choose layer];
    [layer6 setMasksToBounds:YES];
    [layer6 setCornerRadius:4.0]; //when radius is 0, the border is a rectangle
    [layer6 setBorderWidth:1.0];
    [layer6 setBorderColor:[grey CGColor]];
    _choose.backgroundColor = grey;
    
    CALayer * layer7 = [_take layer];
    [layer7 setMasksToBounds:YES];
    [layer7 setCornerRadius:4.0]; //when radius is 0, the border is a rectangle
    [layer7 setBorderWidth:1.0];
    [layer7 setBorderColor:[grey CGColor]];
    _take.backgroundColor = grey;
    
    CALayer * layer8 = [_clear layer];
    [layer8 setMasksToBounds:YES];
    [layer8 setCornerRadius:4.0]; //when radius is 0, the border is a rectangle
    [layer8 setBorderWidth:1.0];
    [layer8 setBorderColor:[grey CGColor]];
    _clear.backgroundColor = grey;
    
    CALayer * layer9 = [_imageView layer];
    [layer9 setMasksToBounds:YES];
    [layer9 setCornerRadius:4.0]; //when radius is 0, the border is a rectangle
    [layer9 setBorderWidth:1.0];
    [layer9 setBorderColor:[grey CGColor]];
    _clear.backgroundColor = grey;
    

}

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
    return UIBarPositionTopAttached;
}

-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.date.inputView;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM/dd/YY"];
    NSString *dateString = [dateFormatter stringFromDate:picker.date];
    
    
    self.date.text = dateString;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Save:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (self.device) {
        
        // Update existing device
        [self.device setValue:self.name.text forKey:@"name"];
        [self.device setValue:self.age.text forKey:@"age"];
        [self.device setValue:self.date.text forKey:@"date"];
        [self.device setValue:self.pname.text forKey:@"pet_name"];
        [self.device setValue:self.notes.text forKey:@"notes"];
        
        
        NSData *imageData = UIImagePNGRepresentation(self.imageView.image);
        [self.device setValue:imageData forKey:@"img"];
        
        
    } else {
    
    // Create a new managed object
    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"List" inManagedObjectContext:context];
    [newDevice setValue:self.name.text forKey:@"name"];
    [newDevice setValue:self.age.text forKey:@"age"];
    [newDevice setValue:self.date.text forKey:@"date"];
    [newDevice setValue:self.notes.text forKey:@"notes"];
    [newDevice setValue:self.pname.text forKey:@"pet_name"];
        
        NSData *imageData = UIImagePNGRepresentation(self.imageView.image);
        [newDevice setValue:imageData forKey:@"img"];
    }
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)Cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (IBAction)selectPhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}
- (IBAction)takePhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}
- (IBAction)clearPhoto:(UIButton *)sender {
    [_imageView setImage:[UIImage imageNamed:@"cute.png"]];
}
@end
