//
//  ApiClient.m
//  Mailbox
//
//  Created by Muhammad Yakubbaev on 4/24/13.
//  Copyright (c) 2013 Muhammad Yakubbaev. All rights reserved.
//

#import "ApiClient.h"
#import "AFHTTPRequestOperationLogger.h"

@implementation ApiClient

- (void)loadMailsWithSuccess:(void(^)(NSArray *mails))success fail:(void(^)(NSString *errorMessage))fail {
    [self getPath: @"emails.json" parameters: nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              success(nil);
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              fail(nil);
          }];
}

+ (id)sharedClient {
    static ApiClient *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[ApiClient alloc] initWithBaseURL:[NSURL URLWithString: @"http://rocket-ios.herokuapp.com"]];
        [[AFHTTPRequestOperationLogger sharedLogger] setLevel: AFLoggerLevelDebug];
        [[AFHTTPRequestOperationLogger sharedLogger] startLogging];
    });
    
    return __sharedInstance;
}

@end
