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

extern NSString*  const WatermelonDefaultPackageDirectoryName;

typedef void(^WatermelonDownloadSuccess)(NSString *zipPath);
typedef void(^WatermelonDownloadFailed)(NSError *error);


/**
 * Package Manager
 *  manage the download of package,update of package and so on
 */

@interface WMPackageManager : NSObject

/**
 * reset
 */
+ (void) checkCurrentVersionIsLatestContinuous:(BOOL) continuous ;

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
+(void) downloadRemotePackageSuccess:(WatermelonDownloadSuccess) success failed:(WatermelonDownloadFailed) failed;

/**
 * install package via local zip package
 */
+(void) installPackageWithDefaultDownloadPath ;

@end
