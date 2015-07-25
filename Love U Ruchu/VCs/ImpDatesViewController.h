//
//  ImpDatesViewController.h
//  
//
//  Created by Ankit Jain on 28/06/15.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Popup.h"

@interface ImpDatesViewController : BaseViewController <PopupDelegate,UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *impTableView;

@end
