//
//  NewUserViewCotroller.m
//  PayMyPocket
//
//  Created by eliran efron on 06/02/14.
//  Copyright (c) 2014 Eliran Efron. All rights reserved.
//

#import "NewUserViewCotroller.h"

@interface NewUserViewCotroller ()

@end

@implementation NewUserViewCotroller
@synthesize createNew, connectToExist, profilePicture, helloText;

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
    self.view.backgroundColor = [self colorWithHexString:@"aeaeae"];
    [self.navigationController.navigationBar setHidden:YES];

    [self loadUserProfilePicture];
    [self setTextForHello];
    
}

- (void) loadUserProfilePicture{
    
    NSString *userFacebookID = @"1733992897";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large",userFacebookID]];
    NSLog(@"%@",userFacebookID);
    NSData *data = [NSData dataWithContentsOfURL:url];
    profilePicture.image = [UIImage imageWithData:data];
    profilePicture.layer.cornerRadius = 50.0f;
    profilePicture.layer.masksToBounds = YES;

}

- (void) setTextForHello{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *firstName = [def valueForKey:@"firstname"];
    NSString *lastName = [def valueForKey:@"lastname"];
    [def synchronize];
    
    helloText.text = [NSString stringWithFormat:@"Hey %@ %@! \n Send pocket money easily to your family and friends!", firstName, lastName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)connectToExistingPocket:(id)sender{
    
    NSString *url = @"http://paymypocket.ifdstudio.co.il/pockets/connect";
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [parameters setObject:[def valueForKey:@"uniq"] forKey:@"userid"];
    [def synchronize];
    
    AFHTTPRequestOperationManager *insideManager = [AFHTTPRequestOperationManager manager];
    [insideManager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"the response %@", responseObject);
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        [def setObject:[responseObject valueForKey:@"pocketID"] forKey:@"pocketID"];
        [def synchronize];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    NSLog(@"connect to existing");
}

- (IBAction)openConnectionDialog:(id)sender
{
    NSString *url = @"http://paymypocket.ifdstudio.co.il/pockets/create";
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [parameters setObject:[def valueForKey:@"uniq"] forKey:@"userid"];
    [def synchronize];
    
    AFHTTPRequestOperationManager *insideManager = [AFHTTPRequestOperationManager manager];
    [insideManager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"the response %@", responseObject);
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        [def setObject:[responseObject valueForKey:@"pocketID"] forKey:@"pocketID"];
        [def synchronize];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

    NSLog(@"connect to existing");
}

- (IBAction)createNewPocket:(id)sender{
    NSString *url = @"http://paymypocket.ifdstudio.co.il/pockets/create";
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [parameters setObject:[def valueForKey:@"uniq"] forKey:@"userid"];
    [def synchronize];
    
    AFHTTPRequestOperationManager *insideManager = [AFHTTPRequestOperationManager manager];
    [insideManager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"the response %@", responseObject);
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        [def setObject:[responseObject valueForKey:@"pocketID"] forKey:@"pocketID"];
        [def synchronize];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    NSLog(@"create a new pocket");
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
