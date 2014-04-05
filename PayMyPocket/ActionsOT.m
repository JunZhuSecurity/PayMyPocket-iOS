//
//  ActionsOT.m
//  PayMyPocket
//
//  Created by eliran efron on 07/02/14.
//  Copyright (c) 2014 Eliran Efron. All rights reserved.
//

#import "ActionsOT.h"

@implementation ActionsOT

@synthesize ID = _ID;
@synthesize pocketID = _pocketID;
@synthesize description = _description;
@synthesize credits = _credits;
@synthesize type = _type;
@synthesize status = _status;

- (id)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        self.ID = [[dictionary valueForKey:@"Id"] integerValue];
        self.pocketID = [dictionary valueForKey:@"pocketID"];
        self.description = [dictionary valueForKey:@"desc"];
        self.credits = [[dictionary valueForKey:@"credits"] integerValue];
        self.type = [[dictionary valueForKey:@"type"] integerValue];
        //self.status = [[dictionary valueForKey:@"status"] integerValue];
        self.status = -1;
    }
    return self;
}

@end