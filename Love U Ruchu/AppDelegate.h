//
//  AppDelegate.h
//  Love U Ruchu
//
//  Created by Ankit Jain on 04/06/15.
//  Copyright (c) 2015 Ankit Jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic)  NSDate *date;
-(void)getNextMonthDate;
@end

