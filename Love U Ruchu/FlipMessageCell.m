//
//  FlipMessageCell.m
//  Love U Ruchu
//
//  Created by Ankit Jain on 05/06/15.
//  Copyright (c) 2015 Ankit Jain. All rights reserved.
//

#import "FlipMessageCell.h"

@implementation FlipMessageCell

-(void)decorateWithText:(NSString *)text {
    self.messageLabel.textSize = 24;
    self.messageLabel.fixedLenght = text.length;
    self.messageLabel.textColor = [UIColor clearColor];
    self.messageLabel.flipTextColor = [UIColor whiteColor];
    self.messageLabel.startedFlippingLabelsBlock = ^{ };
    self.messageLabel.finishedFlippingLabelsBlock = ^{ };
    self.messageLabel.text = text;
    self.messageLabel.useSound = NO;
}

@end
