//
//  ViewController.m
//  Love U Ruchu
//
//  Created by Ankit Jain on 04/06/15.
//  Copyright (c) 2015 Ankit Jain. All rights reserved.
//

#import "JuneViewController.h"
#import "FlipMessageCell.h"
#import "MessagesViewController.h"

@interface JuneViewController ()
{
    SWBufferedToast *popUpToast;
    SWBufferedToast *messagesToast;
    NSArray *tableData;
    int timeInterval;
    NSInteger index;
    NSArray *messagesArray;
    NSTimer *timer;
}

@end

@implementation JuneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    timeInterval = 30;

    index = [self getMessagesIndex];
    [self readPlistFile];
    if (messagesArray.count <= index) {
        index = -1;
        [self updateMessagesIndex];
    }
    
    // Do any additional setup after loading the view, typically from a nib.
    // Initialize table data
    UIView *background = [[UIView alloc] initWithFrame:self.tableView.frame];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:background.frame];
    [imgView setImage:[UIImage imageNamed:@"background4"]];
    imgView.clipsToBounds = YES;
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    [background addSubview:imgView];
    
    [self showLoginSuccessToast];
    self.tableView.contentInset = UIEdgeInsetsMake(-1.0f, 0.0f, 0.0f, 0.0);
    [self.tableView setBackgroundView:background];
    [self readPlistFile];
}

-(void)viewWillAppear:(BOOL)animated {
    // Show navigation bar
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationBar setBackgroundColor:self.view.backgroundColor];

    // Hide back button
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"hamburger"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu:)];
    self.navigationItem.leftBarButtonItem = anotherButton;
}

-(void)updateMessagesIndex {
    index++;
    if (messagesArray.count <= index) {
        index = 0;
    }
    [[NSUserDefaults standardUserDefaults] setInteger:index forKey:@"MESSAGES_COUNT"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSInteger)getMessagesIndex {
    NSInteger ind = [[NSUserDefaults standardUserDefaults] integerForKey:@"MESSAGES_COUNT"];
    return ind;
}

-(void)readPlistFile{
    messagesArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Messages" ofType:@"plist"]];
}

-(void)showNotification {
    [self updateMessagesIndex];
    [popUpToast dismiss];
    [messagesToast dismiss];
    
    messagesToast = [[SWBufferedToast alloc] initPlainToastWithTitle:nil subtitle:[messagesArray objectAtIndex:index] actionButtonText:@"Tap to read all!" backgroundColor:[UIColor clearColor] toastColor:[UIColor redColor] animationImageNames:[NSArray arrayWithObjects:@"letsFallInLoveBg", nil] andDelegate:self onView:self.view];
    [messagesToast appear];
}

-(void)showLoginSuccessToast {
    popUpToast = [[SWBufferedToast alloc] initPlainToastWithTitle:@"Love You Ruchu" subtitle:@"Happy 3 months anniversary :)" actionButtonText:@"Surprise me more!" backgroundColor:[UIColor clearColor] toastColor:[UIColor redColor] animationImageNames:[NSArray arrayWithObjects:@"letsFallInLoveBg", nil] andDelegate:self onView:self.view];
    [popUpToast appear];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SWBufferedToastDelegate

- (void)didTapActionButtonWithToast:(SWBufferedToast*)toast {
    if (toast) {
        [toast dismiss];

        if (toast == popUpToast) {
            timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                                     target:self
                                                   selector:@selector(showNotification)
                                                   userInfo:nil
                                                    repeats:YES];
            
            tableData = [NSArray arrayWithObjects:@"This day is", @"a reminder", @"of the best", @"decision of", @"my life to", @"propose to,", @"and", @"get married", @"to the", @"worlds most", @"beautiful", @"woman.", @"Happy", @"anniversary", @"Ruchu",  nil];
            [self.tableView reloadData];
        } else {
            NSLog(@"Nothing");
            MessagesViewController *messageVc =
            [[UIStoryboard storyboardWithName:@"Main" bundle:NULL]
             instantiateViewControllerWithIdentifier:@"MessagesViewController"];
            [self.navigationController pushViewController:messageVc animated:YES];
        }
    }
}

#pragma mark - UITableView

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.0f;
}

- (NSString*) tableView:(UITableView *) tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"messageCell";
    
    FlipMessageCell *cell = (FlipMessageCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[FlipMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    [cell decorateWithText:[tableData objectAtIndex:indexPath.row]];
    
    return cell;
}

@end
