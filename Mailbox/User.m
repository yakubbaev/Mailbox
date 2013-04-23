//
//  User.m
//  Mailbox
//
//  Created by Muhammad Yakubbaev on 4/24/13.
//  Copyright (c) 2013 Muhammad Yakubbaev. All rights reserved.
//

#import "User.h"

@implementation User

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return nil;
}


// input string could be:
// a) kane_rohan@hayessatterfield.uk
// b) Bertram Skiles <mayra@schneidermayert.com>

+ (NSValueTransformer *)uglyTransormer {
    return [MTLValueTransformer transformerWithBlock:^(NSString *str) {
        User *user = User.new;
        NSString *email;
        
        NSString *expression = @"<[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}>";
        NSError *error;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
        NSTextCheckingResult *match = [regex firstMatchInString: str options:0 range:NSMakeRange(0, [str length])];
        if (match){
            NSString *name = [[str substringToIndex: match.range.location] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
            [user setValue: name forKey: @"name"];
            email = [[str substringWithRange: match.range] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString: @"<>"]];
        } else {
            email = str;
        }
        [user setValue: email forKey: @"emailAddress"];
        
        return user;
    }];
}

@end
