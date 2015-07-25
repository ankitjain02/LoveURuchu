//
//  JulyViewController.h
//  
//
//  Created by Ankit Jain on 27/06/15.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "JTSlideShadowAnimation.h"

@interface JulyViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) JTSlideShadowAnimation *shadowAnimation;

@end
