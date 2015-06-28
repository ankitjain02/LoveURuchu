//
//  MessagesViewController.h
//  Love U Ruchu
//
//  Created by Ankit Jain on 08/06/15.
//  Copyright (c) 2015 Ankit Jain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VPRubberSettings.h"
#import "BaseViewController.h"

@interface MessagesViewController : BaseViewController <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@end
