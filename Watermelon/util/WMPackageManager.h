//
//  WMPackageManager.h
//  Watermelon
//
//  Created by zhujinhui on 2017/8/7.
//  Copyright © 2017年 kyson. All rights reserved.
//

#import <Foundation/Foundation.h>

#define URL_VER_JSON @"http://www.kyson.cn/demo/ver.json"

static NSString  *WatermelonNotificationNewVersionFinded = @"cn.kyson.Notification.WatermelonNotificationNewVersionFinded";

#define K_DEFAULT_PACKAGE_NAME @"dist"

typedef void(^WatermelonDownloadSuccess)(void);
typedef void(^WatermelonDownloadFailed)(void);


/**
 * Package Manager
 *  manage the download of package,update of package and so on
 */

@interface WMPackageManager : NSObject

/**
 * check if the version is latest
 */
+ (void) checkCurrentVersionIsLatest ;

/**
 * uncheck
 */
+ (void) stopCheckCurrentVersionIsLatest ;

/**
 * the package in document direcory exists or not
 */
+(BOOL) isPackageExists;


/**
 * install local package
 */
+(void) installLocalPackage ;

/**
 * install remote package from ver.json
 */
+(void) installRemotePackageSuccess:(WatermelonDownloadSuccess) success failed:(WatermelonDownloadFailed) failed;



@end
