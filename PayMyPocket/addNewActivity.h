//
//  addNewActivity.h
//  PayMyPocket
//
//  Created by gil maman on 07/02/2014.
//  Copyright (c) 2014 gil maman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addNewActivity : UIViewController <UITextFieldDelegate> {
    NSString * pocketID;
    NSString * numberCredits;
    NSString * type;
    NSString * repeat;
    NSString * desc;
}
@property (strong, nonatomic) IBOutlet UILabel *creditrsReward;
@property (strong, nonatomic) IBOutlet UIButton* lastSelected;
@property (strong, nonatomic) IBOutlet UIButton* lastSelectedRepeat;
@property (weak, nonatomic) IBOutlet UITextField *description;

- (IBAction)changeCredits:(UIStepper *)sender;
- (IBAction)activityType:(id)sender;
- (IBAction)repeatType:(id)sender;
- (IBAction)openMoreInfo:(id)sender;
- (IBAction)dismissME:(id)sender;
- (IBAction)sendActivity:(id)sender;

@end
