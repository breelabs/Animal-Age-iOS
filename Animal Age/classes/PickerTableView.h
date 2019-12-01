//
//  PickerTableView.h
//  Animal Age Converter
//
//  Created by Jon Brown on 2/17/14.
//  Copyright (c) 2014 Jon Brown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Calc.h"

@protocol AnimalPickerControllerDelegate <NSObject>

@required
- (void)itemSelectedatRow:(NSInteger)row;

@end

@interface PickerTableView : UITableViewController



@property (strong, nonatomic) NSArray *tableData;
@property (assign, nonatomic) id <AnimalPickerControllerDelegate> delegate;

@end
