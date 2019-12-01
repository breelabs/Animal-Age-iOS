//
//  DetailNewsController.m
//  Animal Age Converter
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
    
    
    NSAttributedString *attributedString = [[NSAttributedString alloc]
                          initWithData: [self.selecteddesc dataUsingEncoding:NSUnicodeStringEncoding]
                               options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                    documentAttributes: nil
                                 error: nil
                ];
    textView.attributedText = attributedString;
    
    imgView.image = self.selectedimage;
    lablView.text = self.selectedlabel;
    
    lablView.textContainer.maximumNumberOfLines = 2;
    lablView.textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
        
    [super viewDidLoad];
    
#pragma mark - Button Style
    
    // R: 76 G: 76 B: 76
    UIColor *buttColor = [UIColor colorWithRed:(255.0 / 255.0) green:(255.0 / 255.0) blue:(255.0 / 255.0) alpha: 1];
    
    CALayer * layer = [customButtonHome layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:4.0]; //when radius is 0, the border is a rectangle
    [layer setBorderWidth:1.0];
    [layer setBorderColor:[buttColor CGColor]];

}

-(IBAction)Dismiss:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    NSAttributedString *attributedString = [[NSAttributedString alloc]
                          initWithData: [self.selecteddesc dataUsingEncoding:NSUnicodeStringEncoding]
                               options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                    documentAttributes: nil
                                 error: nil
                ];
    self.textView.attributedText = attributedString;
    
    self.imgView.image = self.selectedimage;
    self.lablView.text = self.selectedlabel;
    
    lablView.textContainer.maximumNumberOfLines = 2;
    lablView.textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
    
    [lablView setText:selectedlabel];
    
    [textView setFont:[UIFont systemFontOfSize:17]];
    
    UIImage * randomImage = [ UIImage imageNamed:[ NSString stringWithFormat:@"image%u.jpg", 1+arc4random_uniform(6) ] ] ;
    [imgView setImage:randomImage];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
