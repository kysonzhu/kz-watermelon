//
//  WMJsonHandler.h
//  Watermelon
//
//  Created by zhujinhui on 2017/8/7.
//  Copyright © 2017年 kyson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMJsonHandler : NSObject

/**
 * convert json to object(dictionary or arrary)
 */
+ (instancetype)jsonObjectWithString:(NSString *)jsonStr ;


@end
