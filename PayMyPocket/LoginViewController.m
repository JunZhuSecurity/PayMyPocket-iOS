//
//  LoginViewController.m
//  PayMyPocket
//
//  Created by eliran efron on 06/02/14.
//  Copyright (c) 2014 Eliran Efron. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSLog(@"loaded");
    
    self.view.backgroundColor = [self colorWithHexString:@"aeaeae"];
    [self.navigationController.navigationBar setHidden:YES];
    /*
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 300, 280, 30)];
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"facebook login" forState:UIControlStateNormal];
    btn.imageView.image = [UIImage imageNamed:@"some.png"];
    [btn addTarget:self action:@selector(facebookButtonLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
     */
}

- (IBAction)facebookButtonLogin:(id)sender {
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if (appDelegate.session.isOpen) {
        [appDelegate.session closeAndClearTokenInformation];
    } else {
        if (appDelegate.session.state != FBSessionStateCreated) {
            appDelegate.session = [[FBSession alloc] init];
        }
        [appDelegate.session openWithCompletionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
            NSString *urlString = [NSString stringWithFormat:@"https://graph.facebook.com/me?access_token=%@",appDelegate.session.accessTokenData.accessToken];
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"JSON: %@", responseObject);
                NSString *url = @"http://paymypocket.ifdstudio.co.il/users/create";
                AFHTTPRequestOperationManager *insideManager = [AFHTTPRequestOperationManager manager];
                NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
                [parameters setObject:[responseObject valueForKey:@"id"] forKey:@"facebookId"];
                [parameters setObject:[NSString stringWithFormat:@"%@",appDelegate.session.accessTokenData.accessToken] forKey:@"token"];
                [parameters setObject:[responseObject valueForKey:@"first_name"] forKey:@"firstname"];
                [parameters setObject:[responseObject valueForKey:@"last_name"] forKey:@"lastname"];
                [insideManager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    NSLog(@"JSON: %@", responseObject);
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
    }
} // login with facebook and send user details to the server

- (IBAction)dismissME:(id)sender{
    NSLog(@"dismiss");
    [self dismissViewControllerAnimated:YES completion:nil];
} // dismiss the ViewController

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
