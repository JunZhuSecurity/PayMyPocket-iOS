//
//  ViewController.m
//  PayMyPocket
//
//  Created by eliran efron on 06/02/14.
//  Copyright (c) 2014 Eliran Efron. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [self colorWithHexString:@"aeaeae"];
    [self.navigationController.navigationBar setHidden:YES];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if (!appDelegate.session.isOpen) {
        NSLog(@"session open");
        appDelegate.session = [[FBSession alloc] init];
        if (appDelegate.session.state == FBSessionStateCreatedTokenLoaded) {
            [appDelegate.session openWithCompletionHandler:^(FBSession *session, FBSessionState status, NSError *error) {                
                NSString *urlString = [NSString stringWithFormat:@"https://graph.facebook.com/me?access_token=%@",appDelegate.session.accessTokenData.accessToken];
                AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    NSLog(@"JSON: %@", responseObject);
                    NSString *url = @"http://paymypocket.ifdstudio.co.il/users/create";
                    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
  
                    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
                    [def setObject:[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"id"]] forKey:@"facebookId"];
                    [def setObject:[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"first_name"]] forKey:@"firstname"];
                    [def setObject:[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"last_name"]] forKey:@"lastname"];
                    [def synchronize];
                    
                    [self.navigationController presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"NewUser"] animated:YES completion:nil];

                    [parameters setObject:[responseObject valueForKey:@"id"] forKey:@"facebookId"];
                    [parameters setObject:[NSString stringWithFormat:@"%@",appDelegate.session.accessTokenData.accessToken] forKey:@"token"];
                    [parameters setObject:[responseObject valueForKey:@"first_name"] forKey:@"firstname"];
                    [parameters setObject:[responseObject valueForKey:@"last_name"] forKey:@"lastname"];
                    [def synchronize];
                    AFHTTPRequestOperationManager *insideManager = [AFHTTPRequestOperationManager manager];
                    [insideManager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
                        [def setObject:[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"uniq"]] forKey:@"uniq"];
                        [def synchronize];
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        NSLog(@"Error: %@", error);
                    }];
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"Error: %@", error);
                }];

            }];
        }else{
            NSLog(@"not logged");
            LoginViewController *loginV = (LoginViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
            double delayInSeconds = 0.1;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self.navigationController presentViewController:loginV animated:YES completion:nil];
            });
        }
    }    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) return [UIColor grayColor];
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString length] != 6) return  [UIColor grayColor];
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

@end
