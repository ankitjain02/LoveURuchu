//
//  AugustViewController.m
//  
//
//  Created by Ankit Jain on 25/07/15.
//
//

#import "AugustViewController.h"
#import "ImagesTableViewController.h"

@interface AugustViewController () {
    NSTimer *timer;
    NSArray *selectedImages;
}

@end

@implementation AugustViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.bubbleButton.maxLeft = 100;
    self.bubbleButton.maxRight = 150;
    self.bubbleButton.maxHeight = 500;
    self.bubbleButton.duration = 9;
    
    //self.bubbleButton.images = @[[UIImage imageNamed:@"heart1"], [UIImage imageNamed:@"star"], [UIImage imageNamed:@"heart2"], [UIImage imageNamed:@"heart3"], [UIImage imageNamed:@"heartRing"], [UIImage imageNamed:@"heart4"], [UIImage imageNamed:@"heart5"], [UIImage imageNamed:@"ballon1"], [UIImage imageNamed:@"heart6"], [UIImage imageNamed:@"heart7"]];
}

-(void)viewWillAppear:(BOOL)animated {
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"IMAGES_SELECTED"] == nil) {
        selectedImages = @[@"heart1", @"heart2", @"heart6"];
        [[NSUserDefaults standardUserDefaults] setValue:selectedImages forKey:@"IMAGES_SELECTED"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        selectedImages = [[NSUserDefaults standardUserDefaults] valueForKey:@"IMAGES_SELECTED"];
    }
    
    NSMutableArray *heartsArray = [NSMutableArray array];
    for (NSString *imageName in selectedImages) {
        [heartsArray addObject:[UIImage imageNamed:imageName]];
    }
    self.bubbleButton.images = heartsArray;
    
    [timer invalidate];
    timer = nil;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                             target:self
                                           selector:@selector(updateTime)
                                           userInfo:nil
                                            repeats:YES];
    
    self.view.backgroundColor = [UIColor colorWithRed:208.0f/255.0f green:78.0f/255.0f blue:90.0f/255.0f alpha:1.0f];
    
    // Show navigation bar
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationBar setBackgroundColor:self.view.backgroundColor];
    
    // Hide back button
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"hamburger"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu:)];
    self.navigationItem.leftBarButtonItem = anotherButton;
    
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(changeImages)];
    self.navigationItem.rightBarButtonItem = settingsButton;
    
    self.title = @"August";
}

-(void)viewDidDisappear:(BOOL)animated {
    [timer invalidate];
    timer = nil;
}

-(void)changeImages {
    ImagesTableViewController *augustVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ImagesTableViewController"];
    [self.navigationController pushViewController:augustVC animated:YES];
}

-(void)updateTime
{
    //TODO::
    [self startGenerate:nil];
    return;
    
    // Get date
    NSDate* date = [self getDate];
    
    //Get the time left until the specified date
    NSInteger ti = ((NSInteger)[date timeIntervalSinceNow]);
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600) % 24;
    NSInteger days = (ti / 86400);
    // NSLog(@"day %d hours %d mins %d sec %d", days, hours, minutes, seconds);
    if (days <= 0 && hours <= 0 && minutes <= 0 && seconds <= 0) {
        [timer invalidate];
        timer = nil;
        
        // NSLog(@"==========================Push view controller==========================");
        //[self performSelector:@selector(removeLoader) withObject:nil afterDelay:3.0f];
        //[self performSelector:@selector(changeAlphaValue) withObject:nil afterDelay:15.0f];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startGenerate:(id)sender {
    [self.bubbleButton generateBubbleInRandom];
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
