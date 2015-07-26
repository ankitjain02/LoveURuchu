//
//  IconImagesViewController.m
//  
//
//  Created by Ankit Jain on 26/07/15.
//
//

#import "IconImagesViewController.h"
#import "YALChatDemoCollectionViewCell.h"

@interface IconImagesViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet UICollectionView *imageDataCollectionView;
@property (nonatomic, strong) NSMutableArray *selectedImages;
@property (nonatomic, copy) NSArray *imagesArray;

@end

@implementation IconImagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectedImages = [[[NSUserDefaults standardUserDefaults] valueForKey:@"IMAGES_SELECTED"] mutableCopy];
    self.imagesArray = @[@"heart1", @"heart2", @"heart3", @"heart4", @"heart5", @"heart6", @"heart7", @"heart8", @"heart9", @"heart10", @"heart11", @"heart12", @"heart13", @"heart14", @"heart15", @"star", @"heartRing", @"ballon1", @"kiss1", @"choco1", @"choco2"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.imageDataCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    
    [self prepareVisibleCellsForAnimation];

    // Show navigation bar
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationBar setBackgroundColor:self.imageDataCollectionView.backgroundColor];
    
    // Hide back button
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction)];
    self.navigationItem.leftBarButtonItem = settingsButton;
}

-(void)doneAction {
    [[NSUserDefaults standardUserDefaults] setValue:self.selectedImages forKey:@"IMAGES_SELECTED"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self animateVisibleCells];
}

#pragma mark - Private

- (void)prepareVisibleCellsForAnimation {
    for (int i = 0; i < [self.imageDataCollectionView.visibleCells count]; i++) {
        YALChatDemoCollectionViewCell * cell = (YALChatDemoCollectionViewCell *) [self.imageDataCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        cell.frame = CGRectMake(-CGRectGetWidth(cell.bounds), cell.frame.origin.y, CGRectGetWidth(cell.bounds), CGRectGetHeight(cell.bounds));
        cell.alpha = 0.f;
    }
}

- (void)animateVisibleCells {
    for (int i = 0; i < [self.imageDataCollectionView.visibleCells count]; i++) {
        YALChatDemoCollectionViewCell * cell = (YALChatDemoCollectionViewCell *) [self.imageDataCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        
        cell.alpha = 1.f;
        [UIView animateWithDuration:0.25f
                              delay:i * 0.1
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             cell.frame = CGRectMake(0.f, cell.frame.origin.y, CGRectGetWidth(cell.bounds), CGRectGetHeight(cell.bounds));
                         }
                         completion:nil];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.imagesArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YALChatDemoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([YALChatDemoCollectionViewCell class]) forIndexPath:indexPath];
    
    UIImage *image = [UIImage imageNamed:[self.imagesArray objectAtIndex:indexPath.row]];
    
    BOOL showSelected = [self.selectedImages containsObject:[self.imagesArray objectAtIndex:indexPath.row]];
    cell.accessoryType = showSelected;
    
    [cell configureCellWithImage:image
                        userName:[self.imagesArray objectAtIndex:indexPath.row]
                     messageText:showSelected ? @"Selected" : @"Not Selected"
                        dateText:showSelected ? @"✓" : nil];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionViewLayout;
    
    return CGSizeMake(CGRectGetWidth(self.view.bounds), layout.itemSize.height);
}

#pragma mark - UICollectionView Delegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (![self.selectedImages containsObject:[self.imagesArray objectAtIndex:indexPath.row]]) {
        [self.selectedImages addObject:[self.imagesArray objectAtIndex:indexPath.row]];
    } else {
        [self.selectedImages removeObject:[self.imagesArray objectAtIndex:indexPath.row]];
    }
    
    YALChatDemoCollectionViewCell *cell = (YALChatDemoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (!cell.accessoryType) {
        cell.accessoryType = YES;
    } else {
        cell.accessoryType = NO;
    }

    [self.imageDataCollectionView deselectItemAtIndexPath:indexPath animated:YES];
    [self.imageDataCollectionView reloadItemsAtIndexPaths:@[indexPath]];
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
