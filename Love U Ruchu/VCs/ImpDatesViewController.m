//
//  ImpDatesViewController.m
//  
//
//  Created by Ankit Jain on 28/06/15.
//
//

#import "ImpDatesViewController.h"

@interface ImpDatesViewController () {
    float previousScrollViewYOffset;
    NSMutableArray *datesArray;
}

@property (strong, nonatomic) NSArray *cellColors;

@end

@implementation ImpDatesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self.impTableView setEditing:YES animated:YES];
    self.impTableView.contentInset = UIEdgeInsetsZero;

    _cellColors = @[[UIColor colorWithRed:27.0f/255.0f green:191.0f/255.0f blue:161.0f/255.0f alpha:1.0f],
                    [UIColor colorWithRed:126.0f/255.0f green:113.0f/255.0f blue:128.0f/255.0f alpha:1.0f],
                    [UIColor colorWithRed:255.0f/255.0f green:79.0f/255.0f blue:75.0f/255.0f alpha:1.0f],
                    [UIColor colorWithRed:150.0f/255.0f green:214.0f/255.0f blue:217.0f/255.0f alpha:1.0f],
                    [UIColor colorWithRed:230.0f/255.0f green:213.0f/255.0f blue:143.0f/255.0f alpha:1.0f]];
}

-(void)viewWillAppear:(BOOL)animated {
    [self readPlistFile];
    [self.impTableView reloadData];
    
    // Hide back button
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"hamburger"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu:)];
    self.navigationItem.leftBarButtonItem = anotherButton;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addDatePopUp)];
    self.navigationItem.rightBarButtonItem = rightButton;

    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    [self.navigationItem setTitle:@"Imp Dates"];
}

-(void)addDatePopUp {
    Popup *popup = [[Popup alloc] initWithTitle:@"Add event" subTitle:@"Example: Our first date 11/12/15" textFieldPlaceholders:@[@"Event Eg: Meet at..", @"Date (dd/mm/yy)"] cancelTitle:@"Cancel" successTitle:@"Add" cancelBlock:^{
        
    } successBlock:^{
        
    }];
    [popup setTapBackgroundToDismiss:YES];
    [popup setSwipeToDismiss:YES];
    [popup setOverallKeyboardAppearance:UIKeyboardAppearanceDark];
    [popup setIncomingTransition:PopupIncomingTransitionTypeSlideFromTop];
    [popup setOutgoingTransition:PopupOutgoingTransitionTypeSlideToBottom];
    [popup setKeyboardTypeForTextFields:@[@"DEFAULT", @"NUMBER"]];
    [popup setDelegate:self];
    [popup showPopup];
}

-(void)writeToPlist:(NSString *)text {
    NSString* plistPath = nil;
    NSFileManager* manager = [NSFileManager defaultManager];
    if ((plistPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"ImpDatesToRemember.plist"]))
    {
        if ([manager isWritableFileAtPath:plistPath])
        {
            NSMutableDictionary* infoDict = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
            [infoDict setObject:text forKey:@"fookey"];
            [infoDict writeToFile:plistPath atomically:NO];
            [manager setAttributes:[NSDictionary dictionaryWithObject:[NSDate date] forKey:NSFileModificationDate] ofItemAtPath:[[NSBundle mainBundle] bundlePath] error:nil];
        }
    }
}

-(void)readPlistFile{
    datesArray = [[NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ImpDatesToRemember" ofType:@"plist"]] mutableCopy];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

//- (UIColor *)colorForIndexPath:(NSIndexPath *)ip{
//    switch (ip.row) {
//        case 0: case 10: case 20: case 30:
//            return RGBColor(0, 170, 172);
//            break;
//        case 1: case 11: case 21: case 31:
//            return RGBColor(0, 106, 109);
//            break;
//        case 2: case 12: case 22: case 32:
//            return RGBColor(190, 50, 106);
//            break;
//        case 3: case 13: case 23: case 33:
//            return RGBColor(50, 144, 14);
//            break;
//        case 4: case 14: case 24: case 34:
//            return RGBColor(204, 67, 0);
//            break;
//        case 5: case 15: case 25: case 35:
//            return RGBColor(26, 129, 182);
//            break;
//        case 6: case 16: case 26: case 36:
//            return RGBColor(204, 178, 0);
//            break;
//        case 7: case 17: case 27: case 37:
//            return RGBColor(125, 14, 162);
//            break;
//        case 8: case 18: case 28: case 38:
//            return RGBColor(108, 0, 199);
//            break;
//        case 9: case 19: case 29: case 39:
//            return RGBColor(32, 32, 32);
//            break;
//        default:
//            return [UIColor clearColor];
//            break;
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Miscellenanious

- (UIColor *)colorForIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = indexPath.row;
    return _cellColors[row%_cellColors.count];
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
    return [datesArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
//                                          [UIFont systemFontOfSize:17], NSFontAttributeName,
//                                          nil];
//    
//    CGRect frame = [[datesArray objectAtIndex:indexPath.row] boundingRectWithSize:CGSizeMake(304, FLT_MAX)
//                                            options:NSStringDrawingUsesLineFragmentOrigin
//                                         attributes:attributesDictionary
//                                            context:nil];
//    
//    CGSize size = frame.size;
//    //NSLog(@"=========HEIGHT %f at index %d", size.height, indexPath.row);
//    return (size.height > 44.0f) ? size.height + 30 : 44.0f;
    
    NSString *mytitleString = [datesArray objectAtIndex:indexPath.row];
    UIFont *font = [UIFont systemFontOfSize:17];
    CGSize size =  [mytitleString sizeWithFont:font
                      constrainedToSize:CGSizeMake(self.view.frame.size.width - 16, 999999)
                          lineBreakMode:NSLineBreakByWordWrapping];
    
    if (size.height < 44.0f) {
        return 44.0f;
    }
    
    return size.height + 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"basicCell1";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    UILabel *textLabel = (UILabel *)[cell.contentView viewWithTag:1];
    [cell.contentView setBackgroundColor:[self colorForIndexPath:indexPath]];
    textLabel.text = [datesArray objectAtIndex:indexPath.row];
    [textLabel setBackgroundColor:[UIColor clearColor]];
//   / [textLabel sizeToFit];
   // [cell decorateWithText:[tableData objectAtIndex:indexPath.row]];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [datesArray exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
    [datesArray exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
    [datesArray exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
}

- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleInsert;
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
