//
//  WMPackageManager.m
//  Watermelon
//
//  Created by zhujinhui on 2017/8/7.
//  Copyright © 2017年 kyson. All rights reserved.
//

#import "WMPackageManager.h"

#import <AFURLSessionManager.h>

#import <RealReachability.h>

#import "WMVer.h"

#import "WMJsonHandler.h"

#import "WMEnvironmentConfigure.h"

#import <SSZipArchive.h>

@interface WMPackageManager ()


@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;


@end


@implementation WMPackageManager




/**
 * Judge if the package version is latest
 */
+ (void) checkCurrentVersionIsLatest {
    
    [[RealReachability sharedInstance] startNotifier];
    
    [[RealReachability sharedInstance] reachabilityWithBlock:^(ReachabilityStatus status) {
        
        switch (status) {
            case RealStatusNotReachable:{
                
            }
                break;
            case RealStatusViaWWAN:
            case RealStatusViaWiFi:{
                NSURL *verJsonURL = [NSURL URLWithString:URL_VER_JSON];
                NSError *error = nil;
                NSString *verJson = [NSString stringWithContentsOfURL:verJsonURL encoding:NSUTF8StringEncoding error:&error];
                if (!error) {
                    WMVer *verRemote = [WMVer verWithVerJson:verJson];
                    WMVer *verLocal = [WMVer verWithVerJson:[WMEnvironmentConfigure verJson]];
                    
                    BOOL isEqual = [verRemote versionIsEqualto:verLocal];
                    
                    if (!isEqual) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:WatermelonNotificationNewVersionFinded object:nil];
                    } else {
                        //do nothign
                    }
                    
                    
                    
                    
                    /////////////////////////////////////
                    /**
                     * after get info ,must check again
                     */
                    NSTimer* timer = [NSTimer timerWithTimeInterval:5.f repeats:YES block:^(NSTimer * _Nonnull timer) {
                        //invalidate if after using
                        [timer invalidate];

                        [self checkCurrentVersionIsLatest];
                        
                    }];
                    
                    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
                    /////////////////////////////////////
                }
                
            }
                break;
                
            default:
                break;
        }
        
        
    }];
    
    
    
    
}




-(void)downloadPackageWithURL:(NSString *) packageURL {
    if (!packageURL) {
        return;
    }
    
        //remote address
        NSURL *URL = [NSURL URLWithString:packageURL];
        //configure
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        manager.securityPolicy.allowInvalidCertificates = YES;
        manager.securityPolicy.validatesDomainName=NO;
        //请求
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        
}



+(BOOL)isPackageExists {
    NSString *verJson = [WMEnvironmentConfigure verJson];
    if (verJson) {
        WMVer *ver = [WMVer verWithVerJson:verJson];
        NSString *packageName = ver.data.firstObject.packageName;
        if (packageName.length > 0) {
            NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            NSString *path = [documentDirectory stringByAppendingPathComponent:packageName];
            
            BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:path];
            
            return fileExists;
            
        }
    }
    
    return NO;
}


+(void) installLocalPackage {
    
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *distPath = [documentDirectory stringByAppendingPathComponent:K_DEFAULT_PACKAGE_NAME];
    
    NSString *localPackagePath = [[NSBundle mainBundle] pathForResource:@"watermelon" ofType:@"zip"];
    
    //remove the same name package in document dictory
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:distPath error:nil];
    
    BOOL zipSuccess = [SSZipArchive unzipFileAtPath:localPackagePath toDestination:distPath];
    if (!zipSuccess) {
        NSLog(@"package install failed");
    }
    
}







@end
