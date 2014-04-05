//
//  RewardsOT.m
//  PayMyPocket
//
//  Created by eliran efron on 07/02/14.
//  Copyright (c) 2014 Eliran Efron. All rights reserved.
//

#import "RewardsOT.h"

@implementation RewardsOT

@synthesize ID = _ID;

@synthesize pocketID = _pocketID;
@synthesize credits = _credits;
@synthesize money = _money;

- (id)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        self.ID = [[dictionary valueForKey:@"Id"] integerValue];
        self.pocketID = [dictionary valueForKey:@"pocketID"];
        self.credits = [[dictionary valueForKey:@"credits"] integerValue];
        self.money = [[dictionary valueForKey:@"money"] integerValue];
    }
    return self;
}
@end
