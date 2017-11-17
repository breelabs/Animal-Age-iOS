//
//  AppDelegate.m
//  Animal Age
//
//  Created by Jon Brown on 2/15/14.
//  Copyright (c) 2014 Jon Brown. All rights reserved.
//

#import "AppDelegate.h"
#import "SARate.h"

@implementation AppDelegate

+ (void)initialize
{
    //set the bundle ID. normally you wouldn't need to do this
    //as it is picked up automatically from your Info.plist file
    //but we want to test with an app that's actually on the store

    //configure
    [SARate sharedInstance].daysUntilPrompt = 5;
    [SARate sharedInstance].usesUntilPrompt = 5;
    [SARate sharedInstance].remindPeriod = 30;
    [SARate sharedInstance].promptForNewVersionIfUserRated = YES;
    //enable preview mode
    [SARate sharedInstance].previewMode = NO;
    
    [SARate sharedInstance].email = @"jonbrown2@mac.com";
    // 4 and 5 stars
    [SARate sharedInstance].minAppStoreRaiting = 4;
    [SARate sharedInstance].emailSubject = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    [SARate sharedInstance].emailText = @"Disadvantages: ";
    [SARate sharedInstance].headerLabelText = @"Like app?";
    [SARate sharedInstance].descriptionLabelText = @"Touch the star to rate.";
    [SARate sharedInstance].rateButtonLabelText = @"Rate";
    [SARate sharedInstance].cancelButtonLabelText = @"Not Now";
    [SARate sharedInstance].setRaitingAlertTitle = @"Rate";
    [SARate sharedInstance].setRaitingAlertMessage = @"Touch the star to rate.";
    [SARate sharedInstance].appstoreRaitingAlertTitle = @"Write a review on the AppStore";
    [SARate sharedInstance].appstoreRaitingAlertMessage = @"Would you mind taking a moment to rate it on the AppStore? It won’t take more than a minute. Thanks for your support!";
    [SARate sharedInstance].appstoreRaitingCancel = @"Cancel";
    [SARate sharedInstance].appstoreRaitingButton = @"Rate It Now";
    [SARate sharedInstance].disadvantagesAlertTitle = @"Disadvantages";
    [SARate sharedInstance].disadvantagesAlertMessage = @"Please specify the deficiencies in the application. We will try to fix it!";
    //enable preview mode

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Model"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}
@end
