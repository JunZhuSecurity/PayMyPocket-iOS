//
//  AddRewardViewController.h
//  PayMyPocket
//
//  Created by gil maman on 07/02/2014.
//  Copyright (c) 2014 gil maman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayPalMobile.h"
#import <QuartzCore/QuartzCore.h>

#define kPayPalClientId @"ATFquhD_T209iiDoM5Z-WgZJqNb2zS6rw0mpq04TNB1NKAvpZNMjYg0Dcv-h"
#define kPayPalReceiverEmail @"gil.maman.5@gmail.com"

@interface AddRewardViewController : UIViewController <PayPalPaymentDelegate>
{
    NSInteger paymentAmout;
    NSInteger creditsCount;
}
@property (strong, nonatomic) IBOutlet UILabel *numCredits;
@property (strong, nonatomic) IBOutlet UILabel *moneyCost;

@property(nonatomic,strong)NSString*amount;
@property(nonatomic,strong)NSString*creditsAmount;
@property(nonatomic,strong)NSString*costumerID;

@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, assign, readwrite) BOOL acceptCreditCards;
@property(nonatomic, strong, readwrite) PayPalPayment *completedPayment;

@property(nonatomic, strong, readwrite) IBOutlet UIButton *payButton;
@property(nonatomic, strong, readwrite) IBOutlet UIView *successView;

- (IBAction)changeCredits:(UIStepper*)sender;
- (IBAction)changeWorth:(UIStepper*)sender;
- (IBAction)pay;
@end
