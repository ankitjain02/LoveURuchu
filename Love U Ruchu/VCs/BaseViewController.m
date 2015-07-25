//
//  BaseViewController.m
//  
//
//  Created by Ankit Jain on 27/06/15.
//
//

#import "BaseViewController.h"
#import "InitialViewController.h"
#import "MessagesViewController.h"
#import "JuneViewController.h"
#import "JulyViewController.h"
#import "ImpDatesViewController.h"
#import "AppDelegate.h"
#import "AugustViewController.h"

@interface BaseViewController () <BlurMenuDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSDate *)getDate {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    return delegate.date;
}

-(void)updateDate{
//    NSString *month = [[NSUserDefaults standardUserDefaults] valueForKey:@"GET_DATE"];
//    NSInteger monthInt = [month integerValue] + 1;
//    
//    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%ld", (long)monthInt] forKey:@"GET_DATE"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    
//    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
//    [delegate getNextMonthDate];

}

#pragma - Menu

- (IBAction)showMenu:(id)sender {
    NSArray *items = [[NSArray alloc] initWithObjects:@"Anniversary Countdown", @"Imp Dates", @"Love Quotes", @"June", @"July", @"August", nil];
    BlurMenu *menu = [[BlurMenu alloc] initWithItems:items parentView:self.view delegate:self];
    [menu show];
}

- (void)menuDidShow {
    
}

- (void)menuDidHide {
    
}

- (void)selectedItemAtIndex:(NSInteger)index {
    BOOL animated = NO;
    if (index == 0) {
        InitialViewController *initialVC = [self.storyboard instantiateViewControllerWithIdentifier:@"InitialViewController"];
        [self.navigationController pushViewController:initialVC animated:animated];
    } else if (index == 1) {
        ImpDatesViewController *impVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ImpDatesViewController"];
        [self.navigationController pushViewController:impVC animated:animated];
    } else if (index == 2) {
        MessagesViewController *messageVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MessagesViewController"];
        [self.navigationController pushViewController:messageVC animated:animated];
    } else if (index == 3) {
        JuneViewController *juneVC = [self.storyboard instantiateViewControllerWithIdentifier:@"JuneViewController"];
        [self.navigationController pushViewController:juneVC animated:animated];
    } else if (index == 4) {
        JulyViewController *julyVC = [self.storyboard instantiateViewControllerWithIdentifier:@"JulyViewController"];
        [self.navigationController pushViewController:julyVC animated:animated];
    } else if (index == 5) {
        AugustViewController *augustVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AugustViewController"];
        [self.navigationController pushViewController:augustVC animated:animated];
    }
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
