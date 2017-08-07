//
//  Watermelon.m
//  Watermelon
//
//  Created by zhujinhui on 2017/8/5.
//  Copyright © 2017年 kyson. All rights reserved.
//

#import "Watermelon.h"

#import "WMResourceCacheManager.h"
#import "WMPackageManager.h"


#define K_MEMORY_CAPACITY (1024*1024*4)
#define K_DISK_CAPACITY (1024*1024*20)


@interface Watermelon ()

/**
 * Package Manager
 */
@property (nonatomic, strong) WMPackageManager *packageManager;

@end

@implementation Watermelon


+(Watermelon *) shareInstance{
    static Watermelon *sharedInstance = nil;
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
        
    });
    return sharedInstance;
}


+(void) registeWatermelonService{
    
    [WMPackageManager checkCurrentVersionIsLatest];
    
    WMResourceCacheManager *cacheManager = [[WMResourceCacheManager alloc] initWithMemoryCapacity:K_MEMORY_CAPACITY diskCapacity:K_DISK_CAPACITY diskPath:nil];
    [NSURLCache setSharedURLCache:cacheManager];
}



/**
 * Package Manager
 */
-(WMPackageManager *)packageManager {
    if (!_packageManager) {
        _packageManager = [[WMPackageManager alloc] init];
    }
    
    return _packageManager;
}







@end
