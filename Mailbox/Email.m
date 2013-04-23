//
//  Email.m
//  Mailbox
//
//  Created by Muhammad Yakubbaev on 4/24/13.
//  Copyright (c) 2013 Muhammad Yakubbaev. All rights reserved.
//

#import "Email.h"
#import "User.h"

@implementation Email

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    return dateFormatter;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
    @"ID" : @"id",
    @"receivedAt" : @"received_at",
    };
}

+ (NSValueTransformer *)receivedAtJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [self.dateFormatter dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer *)fromJSONTransformer {
    return User.uglyTransormer;
}

+ (NSValueTransformer *)toJSONTransformer {
    return [MTLValueTransformer transformerWithBlock:^(NSString *str) {
        NSMutableArray *result = NSMutableArray.new;
        NSArray *components = [str componentsSeparatedByString: @", "];
        for (NSString *item in components) {
            User *user = [User.uglyTransormer transformedValue: item];
            [result addObject: user];
        }
        return result;
    }];
}

@end
