//
//  FlipMessageCell.h
//  Love U Ruchu
//
//  Created by Ankit Jain on 05/06/15.
//  Copyright (c) 2015 Ankit Jain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FSDAirportFlipLabel.h>

@interface FlipMessageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet FSDAirportFlipLabel *messageLabel;
-(void)decorateWithText:(NSString *)text;

@end
