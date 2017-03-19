//
//  NewsTableViewController.h
//  Mac Gurus iOS
//
//  Created by Jon on 9/18/16.
//  Copyright © 2016 jonbrown.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface NewsTableViewController : UITableViewController <MBProgressHUDDelegate, UITableViewDelegate,UITableViewDataSource, UIBarPositioningDelegate, UINavigationBarDelegate>
{
    NSArray *_objects;
    NSMutableData *_responseData;
    NSMutableData *responseData;
    MBProgressHUD *HUD;
}


@property (nonatomic, retain) IBOutlet UITableView *NewsTbView;
@property(nonatomic,retain) NSMutableArray *titleArray;
@property(nonatomic,retain) NSMutableArray *descArray;
@property(nonatomic,retain) NSMutableArray *imageArray;
@property(nonatomic,retain) NSMutableArray *linkArray;
@property(nonatomic,retain) NSMutableArray *contArray;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationbar;

@end
