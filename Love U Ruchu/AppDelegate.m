//
//  AppDelegate.m
//  Love U Ruchu
//
//  Created by Ankit Jain on 04/06/15.
//  Copyright (c) 2015 Ankit Jain. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self getNextMonthDate];
    return YES;
}

-(void)getNextMonthDate {
    NSString *month = [[NSUserDefaults standardUserDefaults] valueForKey:@"GET_DATE"];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:10];
    
    [[NSUserDefaults standardUserDefaults] setValue:@"8" forKey:@"GET_DATE"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [comps setMonth:8];
    [comps setYear:2015];

    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    self.date = [gregorian dateFromComponents:comps];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self getNextMonthDate];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
