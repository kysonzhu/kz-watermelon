//
//  WMResourceCacheManager.m
//  Watermelon
//
//  Created by zhujinhui on 2017/8/5.
//  Copyright © 2017年 kyson. All rights reserved.
//

#import "WMResourceCacheManager.h"



#define K_MEMORY_CAPACITY (1024*1024*4)
#define K_DISK_CAPACITY (1024*1024*20)

@interface WMResourceCacheManager ()

/**
 * cached dictionary
 */
@property (nonatomic, strong) NSMutableDictionary *cachedResponsesDictionary;

@end


@implementation WMResourceCacheManager


+ (void) installCacheModule {
    WMResourceCacheManager *cacheManager = [[WMResourceCacheManager alloc] initWithMemoryCapacity:K_MEMORY_CAPACITY diskCapacity:K_DISK_CAPACITY diskPath:nil];
    [NSURLCache setSharedURLCache:cacheManager];
}


- (nullable NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request {
    
    NSString *absoluteString = request.URL.absoluteString;

    /**
     * 先判断本地有没有数据，有的话加载缓存数据
     */
    NSData *cachedData = self.cachedResponsesDictionary[absoluteString];
    if (cachedData) {
        NSURLResponse *response = [[NSURLResponse alloc] initWithURL:request.URL MIMEType:[self generateMIMETypeWithURL:request.URL.absoluteString] expectedContentLength:cachedData.length textEncodingName:nil];
        NSCachedURLResponse *cacheResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:cachedData];
        return cacheResponse;
    }
    
    
    
    
    
    NSString *urlPath = request.URL.path;
    if (urlPath.length > 0) {
        NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [documentDirectory stringByAppendingPathComponent:@"watermelon"];
        NSString *lastPath = [path stringByDeletingPathExtension];
        NSString *detailPath = [lastPath stringByAppendingString:urlPath];
        
        // 判断文件是否存在，如果存在就加载本地文件，不存在就加载远端文件
        NSURL *url = [NSURL fileURLWithPath:detailPath];
        BOOL localFileExists = [[NSFileManager defaultManager] fileExistsAtPath:url.path];
        if (localFileExists) {
            //
            NSString *MIMETypeString = [self generateMIMETypeWithURL:request.URL.absoluteString];
            if (MIMETypeString) {
                NSData *localData = [NSData dataWithContentsOfFile:detailPath];
                self.cachedResponsesDictionary[absoluteString] = localData;
                
                NSURLResponse *response3 = [[NSURLResponse alloc] initWithURL:request.URL MIMEType:MIMETypeString expectedContentLength:localData.length textEncodingName:nil];
                NSCachedURLResponse *cacheResponse = [[NSCachedURLResponse alloc] initWithResponse:response3 data:localData];
                return cacheResponse;
                
            }
        }
    }
    
    return [super cachedResponseForRequest:request];
}



/**
 * generate MIMEType
 */
-(NSString *) generateMIMETypeWithURL:(NSString *) URL {
    NSString *MIMETypeString = nil;
    
    if ([URL hasSuffix:@"html"]) {
        MIMETypeString = @"text/html";
    } else if ([URL hasSuffix:@"css"]) {
        MIMETypeString = @"text/css";
    } else if ([URL hasSuffix:@"js"]) {
        MIMETypeString = @"text/javascript";
    } else if ([URL hasSuffix:@"jpg"]) {
        MIMETypeString = @"image/jpeg";
    }else if ([URL hasSuffix:@"png"]) {
        MIMETypeString = @"image/png";
    } else if ([URL hasSuffix:@"pdf"]){
        MIMETypeString = @"application/pdf";
    } else if ([URL hasSuffix:@"pdf"]){
        MIMETypeString = @"audio/wav";
    } else {
        ;
    }
    
    return MIMETypeString;
}












@end
