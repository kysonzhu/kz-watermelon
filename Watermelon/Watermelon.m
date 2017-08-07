//
//  Watermelon.m
//  Watermelon
//
//  Created by zhujinhui on 2017/8/5.
//  Copyright © 2017年 kyson. All rights reserved.
//

#import "Watermelon.h"

#import "WMResourceCacheManager.h"

#define K_MEMORY_CAPACITY (1024*1024*4)
#define K_DISK_CAPACITY (1024*1024*20)

@implementation Watermelon













+(void) registeWatermelonService{
    
    WMResourceCacheManager *cacheManager = [[WMResourceCacheManager alloc] initWithMemoryCapacity:K_MEMORY_CAPACITY diskCapacity:K_DISK_CAPACITY diskPath:nil];
    [NSURLCache setSharedURLCache:cacheManager];
}




@end
