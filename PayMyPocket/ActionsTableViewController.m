//
//  ActionsTableViewController.m
//  PayMyPocket
//
//  Created by eliran efron on 07/02/14.
//  Copyright (c) 2014 Eliran Efron. All rights reserved.
//

#import "ActionsTableViewController.h"

@interface ActionsTableViewController ()

@end

@implementation ActionsTableViewController
@synthesize myTable;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [self colorWithHexString:@"3a3f45"];
    myTable.allowsSelection = NO;
    self.navigationController.navigationBar.hidden = YES;
    [self fetchActivities];
    
    activitiesArray = [NSMutableArray array];
    namesArray = [NSMutableArray arrayWithObjects:
                  @"Go to bed",
                  @"Clean your room",
                  @"Do your homework",
                  @"Gardening",
                  @"Take the dog",
                  @"Wash dishes",
                  @"Wake up in time",
                  @"Brush your teeth",
                  @"Other",
                  nil];
    refreshCounter = 0;
}
-(void) viewDidAppear:(BOOL)animated{
    [self fetchActivities];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    refreshCounter++;
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    // return single cell height
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [activitiesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%d",(long)indexPath.row,refreshCounter];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    ActionsOT *action = [activitiesArray objectAtIndex:indexPath.row];

    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell setHighlighted:NO];

    [cell setBackgroundColor:[self colorWithHexString:@"3a3f45"]];
    
    UIImageView *leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
    leftImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",(int)action.type]];
    [cell addSubview:leftImage];
    
    UIButton *doneButton = [[UIButton alloc] initWithFrame:CGRectMake(240, 10, 72, 40)];
    doneButton.backgroundColor = [self colorWithHexString:@"2ecc71"];
    doneButton.layer.cornerRadius = 20.0f;
    doneButton.layer.masksToBounds = YES;
    NSString *doneButtonTitle = [NSString stringWithFormat:@"Award %d \n Credits", (int)action.credits];
    [doneButton setTitle:doneButtonTitle forState:UIControlStateNormal];
    doneButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    doneButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    doneButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    doneButton.titleLabel.numberOfLines = 0;
    
    [doneButton addTarget:self action:@selector(doneButtonActive:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:doneButton];
    
    UILabel *actionLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 160, 20)];
    if([action.description isEqualToString:@""]){
        actionLabel.text = [namesArray objectAtIndex:(action.type-1)];
    }else{
        actionLabel.text = action.description;
    }
    actionLabel.textColor = [UIColor whiteColor];
    [cell addSubview:actionLabel];
    
    UILabel *seconderyLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, 45, 20)];
    seconderyLabel.text = @"Credit:";
    seconderyLabel.textColor = [self colorWithHexString:@"696f72"];
    seconderyLabel.font = [UIFont systemFontOfSize:14.0f];
    [cell addSubview:seconderyLabel];
    
    UIImageView *starImage = [[UIImageView alloc] initWithFrame:CGRectMake(115, 35, 10, 12.5f)];
    starImage.image = [UIImage imageNamed:@"starIcon.png"];
    [cell addSubview:starImage];
    
    UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(127, 30, 45, 20)];
    countLabel.text = [NSString stringWithFormat:@"x %d",(int)action.credits];
    countLabel.textColor = [self colorWithHexString:@"99cdc1"];
    countLabel.font = [UIFont systemFontOfSize:12.0f];
    [cell addSubview:countLabel];
    
    return cell;
}

- (void)doneButtonActive:(id)sender{
    NSLog(@"done button clicked");
}

- (void)fetchActivities{
    NSString *url = @"http://paymypocket.ifdstudio.co.il/activities/get";
    AFHTTPRequestOperationManager *insideManager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [parameters setObject:[def valueForKey:@"pocketID"] forKey:@"pocketID"];
    [def synchronize];
    //NSLog(@"params %@",parameters);
    [insideManager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        [activitiesArray removeAllObjects];
        for(id actionDictionary in responseObject)
        {
            ActionsOT *action = [[ActionsOT alloc] initWithDictionary:actionDictionary];
            [activitiesArray addObject:action];
        }
        [self.myTable reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
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
