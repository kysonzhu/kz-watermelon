//
//  WMResourceCacheManager.h
//  Watermelon
//
//  Created by zhujinhui on 2017/8/5.
//  Copyright © 2017年 kyson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMResourceCacheManager : NSURLCache


/**
 *  install cache module
 */
+ (void) installCacheModule;


+(void)removeCacheModule ;
@end
