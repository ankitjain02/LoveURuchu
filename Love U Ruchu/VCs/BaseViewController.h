//
//  BaseViewController.h
//  
//
//  Created by Ankit Jain on 27/06/15.
//
//

#import <UIKit/UIKit.h>
#import "BlurMenu.h"

#define RGBColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

@interface BaseViewController : UIViewController

- (NSDate *)getDate;
- (void)updateDate;
- (IBAction)showMenu:(id)sender;

@end
