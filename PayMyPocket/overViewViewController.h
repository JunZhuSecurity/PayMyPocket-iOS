//
//  overViewViewController.h
//  PayMyPocket
//
//  Created by gil maman on 07/02/2014.
//  Copyright (c) 2014 gil maman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface overViewViewController : UIViewController {
    NSString * pocketID;
}

@property (strong, nonatomic) IBOutlet UILabel *taskDidFromTot;
@property (strong, nonatomic) IBOutlet UILabel *tasksFromLastWeek;
@property (strong, nonatomic) IBOutlet UILabel *moneyMade24;

@property (strong, nonatomic) IBOutlet UILabel *moneyMade7Days;
@property (strong, nonatomic) IBOutlet UILabel *moneyMadeMonth;

@end
