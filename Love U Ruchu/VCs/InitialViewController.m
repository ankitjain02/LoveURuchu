//
//  InitialViewController.m
//  Love U Ruchu
//
//  Created by Ankit Jain on 08/06/15.
//  Copyright (c) 2015 Ankit Jain. All rights reserved.
//

#import "InitialViewController.h"
#import "AugustViewController.h"

@interface InitialViewController () {
    NSDate *date;
    NSTimer *timer;
}

@end

@implementation InitialViewController

-(void)viewDidLoad {

}

-(void)viewWillAppear:(BOOL)animated {
    // Show navigation bar
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationBar setBackgroundColor:self.view.backgroundColor];
    
    [self showGearViewOnLoading];
}

-(void)viewWillDisappear:(BOOL)animated {
    [timer invalidate];
    timer = nil;
}

- (void)showGearViewOnLoading {
    [self.coupleImage setHidden:YES];
    
    [VMGearLoadingView showGearLoadingForView:self.view];
    [self performSelector:@selector(hideGearViewOnLoading) withObject:nil afterDelay:2];
}

- (void)showGearViewOnNavigating {
    [self.coupleImage setHidden:YES];
    
    [VMGearLoadingView showGearLoadingForView:self.view];
    [self performSelector:@selector(hideGearViewOnNavigating) withObject:nil afterDelay:1];
}

-(void)hideGearViewOnLoading {
    [VMGearLoadingView hideGearLoadingForView:self.view];
    [self.coupleImage setHidden:NO];
    [self startCountdown];
}

-(void)hideGearViewOnNavigating {
    [VMGearLoadingView hideGearLoadingForView:self.view];
    [self.coupleImage setHidden:NO];
    AugustViewController *vc =
    [[UIStoryboard storyboardWithName:@"Main" bundle:NULL]
     instantiateViewControllerWithIdentifier:@"AugustViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)startCountdown {
    // Get date
    date = [self getDate];
    
    //Remove the time component from the datePicker.  We care only about the date
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSUInteger preservedComponents = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay);
    date = [calendar dateFromComponents:[calendar components:preservedComponents fromDate:date]];
    
    //Set up a timer that calls the updateTime method every second to update the label
   
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(updateTime)
                                           userInfo:nil
                                            repeats:YES];
}

-(void)updateTime
{
    //Get the time left until the specified date
    NSInteger ti = ((NSInteger)[date timeIntervalSinceNow]);
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600) % 24;
    NSInteger days = (ti / 86400);
   // NSLog(@"day %d hours %d mins %d sec %d", days, hours, minutes, seconds);
    if (days <= 0 && hours <= 0 && minutes <= 0 && seconds <= 0) {
       // NSLog(@"==========================Push view controller==========================");
        [self updateDate];
        [timer invalidate];
        timer = nil;
        [self.countdownLabel setHidden:YES];
        [self showGearViewOnNavigating];
    }
    //Update the label with the remaining time
    self.countdownLabel.text = [NSString stringWithFormat:@"%02li days \n%02li hrs %02li min %02li sec", (long)days, (long)hours, (long)minutes, (long)seconds];
}

@end
