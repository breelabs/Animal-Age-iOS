//
//  AnimalPicker.m
//  Animal Age
//
//  Created by Jon Brown on 2/17/14.
//  Copyright (c) 2014 Jon Brown. All rights reserved.
//

#import "AnimalPicker.h"


@interface AnimalPicker ()

@property (strong, nonatomic) NSArray *animalArray;

@end

@implementation AnimalPicker


- (void)viewDidLoad
{

    [super viewDidLoad];

    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"flipPref"];
    NSString*  flipin = [defaults objectForKey:@"flipPref"];
    int flipValue = [flipin doubleValue];
    NSLog(@"Flip Status: %d", flipValue);
    

    calcText.lineBreakMode = NSLineBreakByWordWrapping;
    calcText.numberOfLines = 0;
    
    
    if ([UIScreen mainScreen].scale == 2.f && [[UIScreen mainScreen] bounds].size.height-568)
    { [calcText setText:@""]; }
    else
    {
        if (flipValue == 0 ) {
            NSString *results = resultLabel.text;
            NSString *animal = AnimalButt.currentTitle;
            [calcText setText:[NSString stringWithFormat:@"You are %@ years old in %@ years", results, animal]];
        } else {
            NSString *results = resultLabel.text;
            NSString *animal = AnimalButt2.currentTitle;
            [calcText setText:[NSString stringWithFormat:@"You are %@ years old in %@ years", results, animal]];
        }
        
    }
    
    #pragma mark - Button Style
    
    // R: 76 G: 76 B: 76
    UIColor *buttColor = [UIColor colorWithRed:(116 / 255.0) green:(116 / 255.0) blue:(116 / 255.0) alpha: 1];
    UIColor *butbackcolor = [UIColor colorWithRed:(150.0 / 255.0) green:(150.0 / 255.0) blue:(150.0 / 255.0) alpha: 1];
    
    CALayer * layer = [AnimalButt layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:4.0]; //when radius is 0, the border is a rectangle
    [layer setBorderWidth:1.0];
    [layer setBorderColor:[buttColor CGColor]];
    
    CALayer * layer2 = [AnimalButt2 layer];
    [layer2 setMasksToBounds:YES];
    [layer2 setCornerRadius:4.0]; //when radius is 0, the border is a rectangle
    [layer2 setBorderWidth:1.0];
    [layer2 setBorderColor:[buttColor CGColor]];
    
    CALayer * calcLayer = [AgeButt layer];
    [calcLayer setMasksToBounds:YES];
    [calcLayer setCornerRadius:4.0]; //when radius is 0, the border is a rectangle
    [calcLayer setBorderWidth:1.0];
    [calcLayer setBorderColor:[butbackcolor CGColor]];
    AgeButt.backgroundColor = butbackcolor;
  
    
    
    #pragma mark - Set WebView
    
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:path1 encoding:NSUTF8StringEncoding error:nil];
    [graphView loadHTMLString:html baseURL:nil];
    
    #pragma mark - Set MainView Color
    
    // R: 190 G: 190 B: 190
    UIColor *myColor = [UIColor colorWithRed:(190.0 / 255.0) green:(190.0 / 255.0) blue:(190.0 / 255.0) alpha: 1];
    
    [mainArea setBackgroundColor:myColor];
    
    #pragma mark - Set Animal Array
    
    self.animalArray = @[ @"Dog", @"Cat", @"Cow",@"Rabbit", @"Duck", @"Chicken"  ];
    
    
     #pragma mark - Set Buttons / View Colors
    
    
    ManView2.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    ManView2.opaque = NO;
    ManView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    ManView.opaque = NO;
    
    HumanAge.backgroundColor = myColor;
    HumanAge.leftView = ManView;
    HumanAge.leftViewMode = UITextFieldViewModeAlways;
    
    
    HumanAge2.backgroundColor = myColor;
    HumanAge2.leftView = ManView2;
    HumanAge2.leftViewMode = UITextFieldViewModeAlways;
    
     #pragma mark - Set Done Button on Number Pad
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancelNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    
    
    
    HumanAge.inputAccessoryView = numberToolbar;
    
    UIToolbar* numberToolbar2 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar2.barStyle = UIBarStyleDefault;
    numberToolbar2.items = [NSArray arrayWithObjects:
                            [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancelNumberPad2)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad2)],
                            nil];
    [numberToolbar2 sizeToFit];
    HumanAge2.inputAccessoryView = numberToolbar2;
    
    [RFRateMe showRateAlert];

}


-(void)cancelNumberPad{
    [HumanAge resignFirstResponder];
    HumanAge.text = @"";
    Calc *theInstance = [[Calc alloc] init];
    [theInstance calcTapped];
    
}

-(void)cancelNumberPad2{
    [HumanAge2 resignFirstResponder];
    HumanAge2.text = @"";
    Calc *theInstance = [[Calc alloc] init];
    [theInstance calcTapped];
    
}

-(void)doneWithNumberPad{
   // NSString *numberFromTheKeyboard = HumanAge.text;
    [HumanAge resignFirstResponder];
    Calc *theInstance = [[Calc alloc] init];
    [theInstance calcTapped];
}

-(void)doneWithNumberPad2{
    // NSString *numberFromTheKeyboard = HumanAge.text;
    [HumanAge2 resignFirstResponder];
    Calc *theInstance = [[Calc alloc] init];
    [theInstance calcTapped];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 2) ? NO : YES;
}

- (IBAction)selectAnimalPressed:(id)sender
{

    UINavigationController *navigationController = (UINavigationController *)[self.storyboard instantiateViewControllerWithIdentifier:@"SimpleTableVC"];
    PickerTableView *tableViewController = (PickerTableView *)[[navigationController viewControllers] objectAtIndex:0];
    tableViewController.tableData = self.animalArray;
    tableViewController.navigationItem.title = @"Animals";
    tableViewController.delegate = self;
   [self.navigationController popToRootViewControllerAnimated:YES];
   [self presentViewController:navigationController animated:YES completion:nil];
    
   
    
}

- (void)itemSelectedatRow:(NSInteger)row
{
    
    NSLog(@"row %lu selected", (unsigned long)row);
    [self->AnimalButt setTitle:[self.animalArray objectAtIndex:row] forState:UIControlStateNormal];
    [self->AnimalButt2 setTitle:[self.animalArray objectAtIndex:row] forState:UIControlStateNormal];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
