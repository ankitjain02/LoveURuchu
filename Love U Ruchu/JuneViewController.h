//
//  ViewController.h
//  Love U Ruchu
//
//  Created by Ankit Jain on 04/06/15.
//  Copyright (c) 2015 Ankit Jain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SWBufferedToast.h>
#import <FSDAirportFlipLabel.h>
#import "BaseViewController.h"

@interface JuneViewController : BaseViewController <SWBufferedToastDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet FSDAirportFlipLabel *messageLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

