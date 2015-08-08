//
//  AugustViewController.m
//
//
//  Created by Ankit Jain on 25/07/15.
//
//

#import "AugustViewController.h"
#import "IconImagesViewController.h"
#import "ClearTextLabel.h"
#import "XHAmazingLoadingView.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)(((rgbValue) & 0xFF0000) >> 16))/255.0 green:((float)(((rgbValue) & 0xFF00) >> 8))/255.0 blue:((float)((rgbValue) & 0xFF))/255.0 alpha:1.0]

@interface AugustViewController () {
    NSTimer *imagetimer;
    NSTimer *timer;
    NSArray *selectedImages;
    BOOL showTime;
}

@property (nonatomic, strong) XHAmazingLoadingView *amazingLoadingView;
@property (nonatomic, strong) IBOutlet ClearTextLabel *objCTLbl;
@property (nonatomic, strong) IBOutlet UIView *flipView;

@end

@implementation AugustViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.bubbleButton.maxLeft = 100;
    self.bubbleButton.maxRight = 150;
    self.bubbleButton.maxHeight = 500;
    self.bubbleButton.duration = 9;
    
    UIImage *inputImage = [UIImage imageNamed:@"background6"];
    self.backgroundImage.image = inputImage;
}

#pragma mark helper

- (BOOL)isReverseFlippingDisabled;
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"reverseFlippingDisabled"];
}

- (void)addClearText {
    // ClearTextLabel* objCTLbl = (ClearTextLabel *)self.messageLabel;//[[ClearTextLabel alloc] initWithFrame:self.view.frame];//CGRectMake(20, 100, 280, 368)];
    self.objCTLbl.text = @"\nHandsome husbands like me are very few. \n\nBut fewer than that are beautiful wives like you. \n\nYou are like a rare pearl in the ocean. \n\nMeant only for me not for everyone.\n\nHappy \n5th month anniversary \nRuchu <3";
    
    //self.objCTLbl.text = @"Nothing can stop our anniversary from being happy, as long as I am your hubby and you are my wifey. I love you :) \n Happy 5th month anniverysary Ruchu <3";
    self.objCTLbl.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:27.0f];
    self.objCTLbl.textAlignment = NSTextAlignmentCenter;
    self.objCTLbl.numberOfLines = 0;
    self.objCTLbl.layer.cornerRadius = 0.0f;
    [self.view addSubview:self.objCTLbl];
    
    [self.objCTLbl sendSubviewToBack:self.bubbleButton];
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
    
    [imagetimer invalidate];
    imagetimer = nil;
    
    imagetimer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                  target:self
                                                selector:@selector(updateTime)
                                                userInfo:nil
                                                 repeats:YES];
    
    self.view.backgroundColor = [UIColor colorWithRed:213.0f/255.0f green:142.0f/255.0f blue:156.0f/255.0f alpha:1.0f];
    
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
    
    self.amazingLoadingView = [[XHAmazingLoadingView alloc] initWithType:XHAmazingLoadingAnimationTypeStar];
    self.amazingLoadingView.loadingTintColor = [UIColor redColor];
    self.amazingLoadingView.backgroundTintColor = [UIColor colorWithRed:213.0f/255.0f green:142.0f/255.0f blue:156.0f/255.0f alpha:1.0f];
    self.amazingLoadingView.frame = self.view.bounds;
    [self.view addSubview:self.amazingLoadingView];
    
    [self.amazingLoadingView startAnimating];
}

-(void)viewDidDisappear:(BOOL)animated {
    [timer invalidate];
    timer = nil;
    
    [imagetimer invalidate];
    imagetimer = nil;
}

-(void)changeImages {
    IconImagesViewController *augustVC = [self.storyboard instantiateViewControllerWithIdentifier:@"IconImagesViewController"];
    [self.navigationController pushViewController:augustVC animated:YES];
}

-(void)updateImages {
    if (showTime) {
        [self startGenerate:nil];
    }
}

-(void)updateTime
{
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
        
        showTime = YES;
        [self.amazingLoadingView stopAnimating];
        [self.amazingLoadingView removeFromSuperview];
        
        [self performSelector:@selector(doAction) withObject:nil afterDelay:1.0f];
    }
}

- (void)doAction {
    [self addClearText];
    [self updateImages];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startGenerate:(id)sender {
    if (showTime) {
        [self.bubbleButton generateBubbleInRandom];
    }
    
}

- (IBAction)flipScreen:(id)sender {
    if (showTime) {
        [self.objCTLbl setHidden:!self.objCTLbl.hidden];
    }
}

- (IBAction)hideBgImage:(id)sender {
    if (showTime) {
        [self.objCTLbl setHidden:!self.objCTLbl.hidden];
        [self.backgroundImage setHidden:!self.backgroundImage.hidden];
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
