//
//  addNewActivity.m
//  PayMyPocket
//
//  Created by gil maman on 07/02/2014.
//  Copyright (c) 2014 gil maman. All rights reserved.
//

#import "addNewActivity.h"

@interface addNewActivity ()

@end

@implementation addNewActivity

@synthesize creditrsReward,lastSelected,lastSelectedRepeat,description;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}


- (IBAction)changeCredits:(UIStepper *)sender {
    int value = [sender value];
    NSString * numberOfCredits = [NSString stringWithFormat:@"x %u",value];
    creditrsReward.text = numberOfCredits;
    
    numberCredits = numberOfCredits;
}

- (IBAction)activityType:(id)sender {
    lastSelected.layer.opacity = 0.6;
    
    UIButton * activityType = (UIButton*)sender;
    
    lastSelected = activityType;
    
    activityType.layer.opacity = 1;
    
    type = [NSString stringWithFormat:@"%ldi",(long)[activityType tag]];
    
}

- (IBAction)repeatType:(id)sender {
    lastSelectedRepeat.layer.opacity = 0.6;
    
    UIButton * activityType = (UIButton*)sender;
    
    lastSelectedRepeat = activityType;
    
    activityType.layer.opacity =1;
    repeat = [NSString stringWithFormat:@"%ldi",(long)[activityType tag]];
}

- (IBAction)openMoreInfo:(id)sender {
    UIAlertView * moreInfoAlert = [[UIAlertView alloc] initWithTitle:@"Enter info" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    UITextField *myTextField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
    [moreInfoAlert addSubview:myTextField];
    [moreInfoAlert show];
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField{

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    CGRect rect = self.view.frame;
    rect.origin.y -=210;
    self.view.frame = rect;
    [UIView commitAnimations];
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    CGRect rect = self.view.frame;
    rect.origin.y +=210;
    self.view.frame = rect;
    [UIView commitAnimations];
    return YES;
}

- (IBAction)sendActivity:(id)sender{
    NSString *url = @"http://paymypocket.ifdstudio.co.il/activities/create";
    AFHTTPRequestOperationManager *insideManager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    numberCredits = [numberCredits stringByReplacingOccurrencesOfString:@"x " withString:@""];
    [parameters setObject:numberCredits forKey:@"credits"];
    [parameters setObject:type forKey:@"type"];
    [parameters setObject:@"" forKey:@"repeat"];
    [parameters setObject:description.text forKey:@"desc"];
    [parameters setObject:pocketID forKey:@"pocketID"];
    NSLog(@"%@",parameters);
    [insideManager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}



- (IBAction)dismissME:(id)sender{
    NSLog(@"dismiss");
    [self.navigationController popViewControllerAnimated:YES];
    
} // dismiss the ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    pocketID = [def valueForKey:@"pocketID"];
    NSLog(@"pocket id %@", pocketID);
    [def synchronize];
    
    numberCredits = [NSString stringWithFormat:@"x %u",1];
    type = [NSString stringWithFormat:@"%ldi",(long)1];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
