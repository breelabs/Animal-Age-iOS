//
//  DetailNewsController.m
//  Mac Gurus iOS
//
//  Created by Jon on 9/18/16.
//  Copyright © 2016 jonbrown.org. All rights reserved.
//

#import "DetailNewsController.h"

@interface DetailNewsController ()

@end

@implementation DetailNewsController
@synthesize imgView, selectedimage, lablView, selectedlabel, selecteddesc, textView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    imgView.image = self.selectedimage;
    lablView.text = self.selectedlabel;
    textView.text = self.selecteddesc;
    
    lablView.textContainer.maximumNumberOfLines = 2;
    lablView.textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
    
    //NSLog(@"TEST3  %@", self.selectedimage);
    
    [super viewDidLoad];
    
#pragma mark - Button Style
    
    // R: 76 G: 76 B: 76
    UIColor *buttColor = [UIColor colorWithRed:(255.0 / 255.0) green:(255.0 / 255.0) blue:(255.0 / 255.0) alpha: 1];
    
    CALayer * layer = [customButtonHome layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:4.0]; //when radius is 0, the border is a rectangle
    [layer setBorderWidth:1.0];
    [layer setBorderColor:[buttColor CGColor]];

    // Do any additional setup after loading the view.
}

-(IBAction)Dismiss:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.imgView.image = self.selectedimage;
    self.lablView.text = self.selectedlabel;
    self.textView.text = self.selecteddesc;
    
    lablView.textContainer.maximumNumberOfLines = 2;
    lablView.textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
    
    [lablView setText:selectedlabel];
    [textView setText:selecteddesc];
    
    [textView setFont:[UIFont systemFontOfSize:17]];
    
    UIImage * randomImage = [ UIImage imageNamed:[ NSString stringWithFormat:@"image%u.jpg", 1+arc4random_uniform(6) ] ] ;
    [imgView setImage:randomImage];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
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

@end
