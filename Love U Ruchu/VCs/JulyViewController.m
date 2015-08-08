//
//  JulyViewController.m
//  
//
//  Created by Ankit Jain on 27/06/15.
//
//

#import "JulyViewController.h"
#import <DGActivityIndicatorView.h>

@interface JulyViewController () {
    NSArray *messagesArray;
    DGActivityIndicatorView *activityIndicatorView;
    UIButton *commingSoonBtn;
    CGFloat alphaValue;
}

@end

@implementation JulyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    messagesArray = [[NSArray alloc] initWithObjects: @"", @"", @"All my dreams,", @"are about making yours", @"come true.", @"Happy 4th month anniversary", @"❤️ Ruchu ❤️", @"😘 Love you 😘", nil];
    [self.tableView setHidden:YES];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self showLoader];

    [self performSelector:@selector(removeLoader) withObject:nil afterDelay:3.0f];
    [self performSelector:@selector(changeAlphaValue) withObject:nil afterDelay:15.0f];
}

-(void)viewWillAppear:(BOOL)animated {
    self.view.backgroundColor = [UIColor colorWithRed:208.0f/255.0f green:78.0f/255.0f blue:90.0f/255.0f alpha:1.0f];
    
    // Show navigation bar
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationBar setBackgroundColor:self.view.backgroundColor];
    
    // Hide back button
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"hamburger"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu:)];
    self.navigationItem.leftBarButtonItem = anotherButton;
    
    self.title = @"July";
}

-(void)viewDidDisappear:(BOOL)animated {
    
}

-(void)changeAlphaValue {
    alphaValue = 0.3f;
    [self.tableView reloadData];
}

-(void)showLoader {
    alphaValue = 0.3f;
    
    activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeRotatingSquares tintColor:[UIColor whiteColor] size:28.0f];
    activityIndicatorView.frame = CGRectMake(0.0f, 0.0f, 50.0f, 50.0f);
    activityIndicatorView.center = self.view.center;
    [self.view addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    
    commingSoonBtn = [[UIButton alloc] init];
    [commingSoonBtn setUserInteractionEnabled:NO];
    [commingSoonBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [commingSoonBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [commingSoonBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [commingSoonBtn setTitle:@"loading..." forState:UIControlStateNormal];
    commingSoonBtn.frame = CGRectMake(0.0f, activityIndicatorView.frame.origin.y + 50, 320, 40.0);
    [self animateButton:commingSoonBtn];
    [self.view addSubview:commingSoonBtn];
}

-(void)removeLoader {
    alphaValue = 0.0f;
    
    [activityIndicatorView stopAnimating];
    [activityIndicatorView removeFromSuperview];
    [commingSoonBtn removeFromSuperview];
    
    [self.tableView reloadData];
    [self.tableView setHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Datasource

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.0f;
}

- (NSString*) tableView:(UITableView *) tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [messagesArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"cell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    [cell setBackgroundColor:[UIColor clearColor]];
    UIButton *messageButton = (UIButton *)[cell.contentView viewWithTag:1];
    [messageButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [messageButton  setTitle:[messagesArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    [messageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self animateButton:messageButton];
    [messageButton setUserInteractionEnabled:NO];
    
    return cell;
}

-(void)animateButton:(UIButton *)animatedView {
    JTSlideShadowAnimation *shadowAnimation = [JTSlideShadowAnimation new];
    shadowAnimation.animatedView = animatedView;
    
    shadowAnimation.shadowBackgroundColor = [UIColor colorWithWhite:0. alpha:alphaValue];
    shadowAnimation.shadowForegroundColor = [UIColor whiteColor];
    shadowAnimation.shadowWidth = 60.;
    shadowAnimation.repeatCount = 300;
    shadowAnimation.duration = 4.;
    
    [shadowAnimation start];
}

#pragma mark - TableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
