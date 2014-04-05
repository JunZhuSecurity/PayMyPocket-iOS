//
//  ActionsOT.h
//  PayMyPocket
//
//  Created by eliran efron on 07/02/14.
//  Copyright (c) 2014 Eliran Efron. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActionsOT : NSObject

@property (nonatomic, assign) NSUInteger ID;
@property (nonatomic, assign) NSUInteger status;
@property (nonatomic, copy) NSString *pocketID;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, assign) NSUInteger credits;
@property (nonatomic, assign) NSUInteger type;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
