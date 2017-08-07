//
//  WMJsonHandler.m
//  Watermelon
//
//  Created by zhujinhui on 2017/8/7.
//  Copyright © 2017年 kyson. All rights reserved.
//

#import "WMJsonHandler.h"

@implementation WMJsonHandler



+ (instancetype)jsonObjectWithString:(NSString *)jsonStr {
    if (jsonStr == nil || (![jsonStr isKindOfClass:[NSString class]])) {
        return nil;
    }
    NSError *error = nil;
    id v = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding]
                                           options:NSJSONReadingMutableContainers
                                             error:&error];
    if (error) {
        NSLog(@"你妹，什么破 json: %@", jsonStr);
        return nil;
    }
    
    return v;
}





@end
