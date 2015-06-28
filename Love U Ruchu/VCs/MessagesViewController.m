//
//  MessagesViewController.m
//  Love U Ruchu
//
//  Created by Ankit Jain on 08/06/15.
//  Copyright (c) 2015 Ankit Jain. All rights reserved.
//

#import "MessagesViewController.h"

@interface MessagesViewController () {
    float previousScrollViewYOffset;
    NSArray *messagesArray;
}

@end

@implementation MessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [self readPlistFile];
    [self.myCollectionView reloadData];
    
    // Hide back button
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"hamburger"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu:)];
    self.navigationItem.leftBarButtonItem = anotherButton;
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    [self.navigationItem setTitle:@"Love Quotes"];
}

-(void)readPlistFile{
    messagesArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Messages" ofType:@"plist"]];
}

- (void)viewDidAppear:(BOOL)animated{
    //Dirty Hack for hiding visual glitch with bouncing of UICollectionView
    
    UIView *newView = [[UIView alloc] initWithFrame:self.view.bounds];
    UIView *top = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height/2)];
    UIView *bot = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/2, self.view.bounds.size.width, newView.bounds.size.height/2)];
    [top setBackgroundColor:[self colorForIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]];
    [bot setBackgroundColor:[self colorForIndexPath:[NSIndexPath indexPathForRow:[messagesArray count]-1 inSection:0]]];
    [newView addSubview:top];
    [newView addSubview:bot];
    [self.view addSubview:newView];
    [self.view bringSubviewToFront:_myCollectionView];
    [_myCollectionView setBackgroundColor:[UIColor clearColor]];
    
    CGRect cf = _myCollectionView.frame;
    cf.origin.y -=CELLS_ALLIGN;
    cf.size.height +=(CELLS_ALLIGN);
    [_myCollectionView setFrame:cf];
    
    
    [super viewDidAppear:animated];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return messagesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VPRubberCell *otherCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    [otherCell setBackgroundColor:[self colorForIndexPath:indexPath]];
    [otherCell.messageLabel setText:[messagesArray objectAtIndex:indexPath.row]];
    return otherCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *string = [messagesArray objectAtIndex:indexPath.row];
    
    UIActivityViewController *activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:@[string]
                                      applicationActivities:nil];
    [self.navigationController presentViewController:activityViewController
                                       animated:YES
                                     completion:^{
                                         // ...
                                     }];
}

- (UIColor *)colorForIndexPath:(NSIndexPath *)ip{
    switch (ip.row) {
        case 0: case 10: case 20: case 30:
            return RGBColor(0, 170, 172);
            break;
        case 1: case 11: case 21: case 31:
            return RGBColor(0, 106, 109);
            break;
        case 2: case 12: case 22: case 32:
            return RGBColor(190, 50, 106);
            break;
        case 3: case 13: case 23: case 33:
            return RGBColor(50, 144, 14);
            break;
        case 4: case 14: case 24: case 34:
            return RGBColor(204, 67, 0);
            break;
        case 5: case 15: case 25: case 35:
            return RGBColor(26, 129, 182);
            break;
        case 6: case 16: case 26: case 36:
            return RGBColor(204, 178, 0);
            break;
        case 7: case 17: case 27: case 37:
            return RGBColor(125, 14, 162);
            break;
        case 8: case 18: case 28: case 38:
            return RGBColor(108, 0, 199);
            break;
        case 9: case 19: case 29: case 39:
            return RGBColor(32, 32, 32);
            break;
        default:
            return [UIColor clearColor];
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
