//
//  NewsTableViewController.m
//  Mac Gurus iOS
//
//  Created by Jon on 9/18/16.
//  Copyright © 2016 jonbrown.org. All rights reserved.
//

#import "NewsTableViewController.h"
#import "RXMLElement.h"
#import "DetailNewsController.h"

#define URLFluxXmlNEWS @"http://www.vetstreet.com/rss/news-feed.jsp?Categories=siteContentTags:dog-news:cat-news:inspiring-stories:animal-news"

@interface NewsTableViewController ()
{
    UIImage *selectedimage;
    NSString *selectedlabel;
    NSString *selecteddesc;
}
@end

@implementation NewsTableViewController
@synthesize NewsTbView,descArray,titleArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"Animal News"];
    
    
    self.navigationbar.delegate = self;
    self.descArray = [[NSMutableArray alloc]init];
    self.titleArray = [[NSMutableArray alloc]init];
    
    NewsTbView.delegate = self;
    NewsTbView.dataSource = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showHUDAddedTo:self.tableView.superview animated:YES];
        HUD.delegate = self;
    });
    
    [self getData];
    //[self setTitle:@"Latest News"];
    
    
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor colorWithRed:0.96 green:0.84 blue:0.09 alpha:1.0];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(getData)
                  forControlEvents:UIControlEventValueChanged];
    
}

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
    return UIBarPositionTopAttached;
}

-(void)getData
{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLFluxXmlNEWS]];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        
        _responseData = [[NSMutableData alloc] init];
        [_responseData appendData:data];
        
        RXMLElement *rootXML = [RXMLElement elementFromXMLData:_responseData];
        
        RXMLElement *rxmlNews = [rootXML child:@"channel"];
        
        NSArray *rxmlIndividualNew = [rxmlNews children:@"item"];
        
        for (int i=0; i<rxmlIndividualNew.count; i++) {
            NSString *title = [NSString stringWithString:[[rxmlIndividualNew objectAtIndex:i] child:@"title"].text];
            NSString *desc = [NSString stringWithString:[[rxmlIndividualNew objectAtIndex:i] child:@"description"].text];
            [titleArray addObject:title];
            [descArray addObject:desc];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [MBProgressHUD hideHUDForView:self.tableView.superview animated:YES];
        });
       
        [self.refreshControl endRefreshing];
        
    }];
    [dataTask resume];
    
    
    
}
- (BOOL)prefersStatusBarHidden {
    return NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return titleArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsCell" forIndexPath:indexPath];
    
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
    
    // Configure the cell...
   cell.textLabel.text = [titleArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    selectedlabel = [NSString stringWithString:[titleArray objectAtIndex:indexPath.item]];
    selecteddesc = [NSString stringWithString:[descArray objectAtIndex:indexPath.item]];

    
    [self performSegueWithIdentifier:@"detailNews" sender:self];

}
#pragma mark prepareForSegue Functions

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"detailNews"]) {
        DetailNewsController *detailNews = [segue destinationViewController];
        detailNews.selectedimage = selectedimage;
        detailNews.selectedlabel = selectedlabel;
        detailNews.selecteddesc = selecteddesc;
    }
    
    
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
