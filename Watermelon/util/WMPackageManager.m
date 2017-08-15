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

@property (nonatomic, assign) BOOL hasStopCheckVersion;

@end


@implementation WMPackageManager




+(WMPackageManager *) shareInstance{
    static WMPackageManager *sharedInstance = nil;
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
        
    });
    return sharedInstance;
}



/**
 * Judge if the package version is latest
 */
+ (void) checkCurrentVersionIsLatest {
    if ([self shareInstance].hasStopCheckVersion) {
        return;
    }
    
        switch ([RealReachability sharedInstance].currentReachabilityStatus) {
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
                        NSDictionary *verRemoteDictionary = [verRemote dictionaryRepresentation];
                        [[NSNotificationCenter defaultCenter] postNotificationName:WatermelonNotificationNewVersionFinded object:verRemoteDictionary];
                    } else {
                        //do nothign
                    }
                    
                    
                    
                    
                    /////////////////////////////////////
                    /**
                     * after get info ,must check again
                     */
                    NSTimer* timer = [NSTimer timerWithTimeInterval:(60.f *5) repeats:YES block:^(NSTimer * _Nonnull timer) {
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
    
}

+ (void) stopCheckCurrentVersionIsLatest {
    [self shareInstance].hasStopCheckVersion = YES;
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

+(void) installPackageWithZipPath:(NSString *) zipPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:zipPath]) {
        return;
    }

    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *distPath = [documentDirectory stringByAppendingPathComponent:K_DEFAULT_PACKAGE_NAME];
    //remove old package
    [fileManager removeItemAtPath:distPath error:nil];

    BOOL zipSuccess = [SSZipArchive unzipFileAtPath:zipPath toDestination:distPath];
    if (zipSuccess) {
        NSString *pathOfVerJson = [distPath stringByAppendingString:@"/ver.json"];
        NSString *verJson = [NSString stringWithContentsOfFile:pathOfVerJson encoding:NSUTF8StringEncoding error:nil];
        [WMEnvironmentConfigure setVerJson:verJson];
    }else {
        
    }
}


+(void) installRemotePackageSuccess:(WatermelonDownloadSuccess)success failed:(WatermelonDownloadFailed)failed{
    NSURL *verJsonURL = [NSURL URLWithString:URL_VER_JSON];
    NSError *error = nil;
    NSString *verJson = [NSString stringWithContentsOfURL:verJsonURL encoding:NSUTF8StringEncoding error:&error];
    if (!error) {
        WMVer *verRemote = [WMVer verWithVerJson:verJson];
        NSString *downloadURL = verRemote.data.firstObject.zipDownloadUrl;
        
        //remote address
        NSURL *URL = [NSURL URLWithString:downloadURL];
        //configure
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        manager.securityPolicy.allowInvalidCertificates = YES;
        manager.securityPolicy.validatesDomainName=NO;
        //请求
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
       
        NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {

            NSLog(@"+++++%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
            
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            
            NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            NSString *watermelonDirectory = [cacheDirectory stringByAppendingPathComponent:response.suggestedFilename];
            
            //remove old package
            NSFileManager *fileManager = [NSFileManager defaultManager];
            [fileManager removeItemAtPath:watermelonDirectory error:nil];
            
            return [NSURL fileURLWithPath:watermelonDirectory];
            
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            //set download finish action
            
            NSString *filePathString = [filePath path];
            //set directory
            NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            NSString *watermelonDirectory = [cacheDirectory stringByAppendingPathComponent:response.suggestedFilename];
            NSString *path = [watermelonDirectory stringByAppendingString:@"/ver.json"];
            [verJson writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
            
            if (error) {
                failed(error);
            } else {
                success(filePathString);
            }
            
            NSLog(@"======");
            
        }];
        
        //download
        [downloadTask resume];
        
    }
    
    
    
}





@end
