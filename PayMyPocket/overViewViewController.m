//
//  overViewViewController.m
//  PayMyPocket
//
//  Created by gil maman on 07/02/2014.
//  Copyright (c) 2014 gil maman. All rights reserved.
//

#import "overViewViewController.h"
#import "AFHTTPRequestOperationManager.h"

@interface overViewViewController ()

@end

@implementation overViewViewController

@synthesize taskDidFromTot,tasksFromLastWeek,moneyMade24,moneyMade7Days,moneyMadeMonth;

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
    pocketID = @"52f4031cf125b";

	
    AFHTTPRequestOperationManager *insideManager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary * parameters =[[NSMutableDictionary alloc]init];
    [parameters setObject:pocketID forKey:@"pocketId"];
    
    [insideManager POST:@"http://paymypocket.ifdstudio.co.il/pockets/statistics" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
