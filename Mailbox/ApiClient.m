//
//  ApiClient.m
//  Mailbox
//
//  Created by Muhammad Yakubbaev on 4/24/13.
//  Copyright (c) 2013 Muhammad Yakubbaev. All rights reserved.
//

#import "ApiClient.h"
#import "AFHTTPRequestOperationLogger.h"
#import "Email.h"
#import "AFJSONRequestOperation.h"

@implementation ApiClient

- (void)loadEmailsWithSuccess:(void(^)(NSArray *emails))success fail:(void(^)(NSString *errorMessage))fail {
    NSURLRequest *request = [self requestWithMethod: @"GET" path: @"emails.json" parameters: nil];
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest: request success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSDictionary *JSON) {
        NSMutableArray *emails = NSMutableArray.new;
        for (NSDictionary *dict in JSON[@"emails"]) {
            NSError *error;
            Email *email = [MTLJSONAdapter modelOfClass: Email.class fromJSONDictionary: dict error: &error];
            NSAssert(email != nil, [error localizedFailureReason]);
            [emails addObject: email];
        }
        success(emails);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        fail([error localizedFailureReason]);
    }];
    [self enqueueHTTPRequestOperation: operation];
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
