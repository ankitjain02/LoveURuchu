//
//  InitialViewController.h
//  Love U Ruchu
//
//  Created by Ankit Jain on 08/06/15.
//  Copyright (c) 2015 Ankit Jain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MZTimerLabel.h>
#import "VMGearLoadingView.h"
#import "BaseViewController.h"

@interface InitialViewController : BaseViewController <BlurMenuDelegate>

@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coupleImage;

@end
