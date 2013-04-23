//
//  Email.h
//  Mailbox
//
//  Created by Muhammad Yakubbaev on 4/24/13.
//  Copyright (c) 2013 Muhammad Yakubbaev. All rights reserved.
//

#import "MTLModel.h"

@class User;
@interface Email : MTLModel <MTLJSONSerializing>
@property (nonatomic, copy, readonly) NSNumber *ID;
@property (nonatomic, strong, readonly) User *from;
@property (nonatomic, strong, readonly) NSArray *to;
@property (nonatomic, copy, readonly) NSString *subject;
@property (nonatomic, copy, readonly) NSString *body;
@property (nonatomic, copy) NSNumber *starred;
@property (nonatomic, copy, readonly) NSNumber *messages;
@property (nonatomic, copy, readonly) NSDate *receivedAt;


@end
