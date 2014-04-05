//
//  RewardsViewController.h
//  PayMyPocket
//
//  Created by eliran efron on 07/02/14.
//  Copyright (c) 2014 Eliran Efron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RewardsOT.h"

@interface RewardsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *activitiesArray;
    NSMutableArray *namesArray;
    
    int refreshCounter;
}

@property (weak, nonatomic) IBOutlet UITableView *myTable;

- (IBAction)dismissME:(id)sender;

@end