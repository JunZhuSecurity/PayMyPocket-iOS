//
//  RewardsOT.h
//  PayMyPocket
//
//  Created by eliran efron on 07/02/14.
//  Copyright (c) 2014 Eliran Efron. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RewardsOT : NSObject

@property (nonatomic, assign) NSUInteger ID;
@property (nonatomic, copy) NSString *pocketID;
@property (nonatomic, assign) NSUInteger credits;
@property (nonatomic, assign) NSUInteger money;

- (id)initWithDictionary:(NSDictionary *)dictionary;


@end
