//
//  User.h
//  Mailbox
//
//  Created by Muhammad Yakubbaev on 4/24/13.
//  Copyright (c) 2013 Muhammad Yakubbaev. All rights reserved.
//

#import "MTLModel.h"

@interface User : MTLModel <MTLJSONSerializing>
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *emailAddress;

+ (NSValueTransformer *)uglyTransormer;

@end
