//
//  DetailNewsController.h
//  Mac Gurus iOS
//
//  Created by Jon on 9/18/16.
//  Copyright © 2016 jonbrown.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailNewsController : UIViewController
{
    IBOutlet UIButton *customButtonHome;
}

- (IBAction)Dismiss:(UIButton *)sender;
@property (nonatomic, retain) UIImage *selectedimage;
@property (nonatomic, retain) NSString *selectedlabel;
@property (nonatomic, retain) NSString *selecteddesc;
@property(nonatomic,retain) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property(nonatomic,retain) IBOutlet UILabel *lablView;
@end
