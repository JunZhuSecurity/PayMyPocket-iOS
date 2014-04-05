//
//  AddRewardViewController.m
//  PayMyPocket
//
//  Created by gil maman on 07/02/2014.
//  Copyright (c) 2014 gil maman. All rights reserved.
//

#import "AddRewardViewController.h"

@interface AddRewardViewController ()

@end

@implementation AddRewardViewController
@synthesize numCredits,moneyCost;
@synthesize amount,costumerID,creditsAmount;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

    [PayPalPaymentViewController setEnvironment:self.environment];
    [PayPalPaymentViewController prepareForPaymentUsingClientId:kPayPalClientId];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    amount = @"10";
    creditsCount = 1;
    self.acceptCreditCards = YES;
    self.environment = PayPalEnvironmentNoNetwork;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeCredits:(UIStepper*)sender {
    int value = [sender value];
    creditsCount = value;
    NSString * numberOfCredits = [NSString stringWithFormat:@"x %u",value];
    numCredits.text = numberOfCredits;
}

- (IBAction)changeWorth:(UIStepper*)sender {
    int value = [sender value];
    amount = [NSString stringWithFormat:@"%d",value];
    NSString *numberOfMoney = [NSString stringWithFormat:@"%u$",value];
    moneyCost.text = numberOfMoney;
}

// PayPal:


- (IBAction)pay {
    // Remove our last completed payment, just for demo purposes.
    self.completedPayment = nil;
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = [[NSDecimalNumber alloc] initWithString:amount];
    payment.currencyCode = @"USD";
    payment.shortDescription = [NSString stringWithFormat:@"PayMyPocket Payment for %d credits", (int)creditsCount];
    NSString *customerId = costumerID;

    [PayPalPaymentViewController setEnvironment:self.environment];
    PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithClientId:kPayPalClientId
                                                                                                 receiverEmail:kPayPalReceiverEmail
                                                                                                       payerId:customerId
                                                                                                       payment:payment
                                                                                                      delegate:self];
    paymentViewController.hideCreditCardButton = !self.acceptCreditCards;
    paymentViewController.languageOrLocale = @"en";
    [self presentViewController:paymentViewController animated:YES completion:nil];
}

#pragma mark - Proof of payment validation

- (void)sendCompletedPaymentToServer:(PayPalPayment *)completedPayment {
    // TODO: Send completedPayment.confirmation to server
    NSLog(@"Here is your proof of payment:\n\n%@\n\nSend this to your server for confirmation and fulfillment.", completedPayment.confirmation);
}

#pragma mark - PayPalPaymentDelegate methods

- (void)payPalPaymentDidComplete:(PayPalPayment *)completedPayment {
    NSLog(@"PayPal Payment Success!");
    self.completedPayment = completedPayment;
    NSString *url = @"http://paymypocket.ifdstudio.co.il/rewards/create";
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:[NSString stringWithFormat:@"%ld",(long)creditsCount] forKey:@"credits"];
    [parameters setObject:amount forKey:@"money"];
    [parameters setObject:[def valueForKey:@"pocketID"] forKey:@"pocketID"];
    [def synchronize];
    AFHTTPRequestOperationManager *insideManager = [AFHTTPRequestOperationManager manager];
    [[insideManager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }]waitUntilFinished];
    [self sendCompletedPaymentToServer:completedPayment]; // Payment was processed successfully; send to server for verification and fulfillment
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalPaymentDidCancel {
    NSLog(@"PayPal Payment Canceled");
    self.completedPayment = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end







