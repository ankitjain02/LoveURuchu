//
//  ImagesTableViewController.m
//  
//
//  Created by Ankit Jain on 25/07/15.
//
//

#import "ImagesTableViewController.h"
#import "ImagesTableViewCell.h"

@interface ImagesTableViewController ()

@property (nonatomic, strong) NSMutableArray *selectedImages;
@property (nonatomic, strong) NSArray *imagesArray;

@end

@implementation ImagesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectedImages = [[[NSUserDefaults standardUserDefaults] valueForKey:@"IMAGES_SELECTED"] mutableCopy];
    self.imagesArray = @[@"heart1", @"heart2", @"heart3", @"heart4", @"heart5", @"heart6", @"heart7", @"heart8", @"heart9", @"heart10", @"heart11", @"heart12", @"heart13", @"heart14", @"heart15", @"star", @"heartRing", @"ballon1", @"kiss1", @"choco1", @"choco2"];
}

-(void)viewWillAppear:(BOOL)animated {
    // Show navigation bar
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationBar setBackgroundColor:self.view.backgroundColor];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.imagesArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ImagesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImagesCell" forIndexPath:indexPath];
    
    UIImage *image = [UIImage imageNamed:[self.imagesArray objectAtIndex:indexPath.row]];
    [cell.iconImage setImage:image];
    cell.label.text = [self.imagesArray objectAtIndex:indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    if ([self.selectedImages containsObject:[self.imagesArray objectAtIndex:indexPath.row]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    ImagesTableViewCell *cell = (ImagesTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//    
    if (![self.selectedImages containsObject:[self.imagesArray objectAtIndex:indexPath.row]]) {
        [self.selectedImages addObject:[self.imagesArray objectAtIndex:indexPath.row]];
    } else {
        [self.selectedImages removeObject:[self.imagesArray objectAtIndex:indexPath.row]];
    }
//
//    if ([self.selectedRows containsObject:[self.imagesArray objectAtIndex:indexPath.row]]) {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    } else {
//        
//    }
    
    ImagesTableViewCell *cell = (ImagesTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType != UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //[self.tagDelegate fillTagField:cell.textLabel.text];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
