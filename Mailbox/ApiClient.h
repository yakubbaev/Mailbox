//
//  ApiClient.h
//  Mailbox
//
//  Created by Muhammad Yakubbaev on 4/24/13.
//  Copyright (c) 2013 Muhammad Yakubbaev. All rights reserved.
//

#import "AFHTTPClient.h"

@interface ApiClient : AFHTTPClient

- (void)loadMailsWithSuccess:(void(^)(NSArray *mails))success fail:(void(^)(NSString *errorMessage))fail;

+ (id)sharedClient;

@end
