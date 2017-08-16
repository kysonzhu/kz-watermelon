//
//  WMVer.h
//  Watermelon
//
//  Created by zhujinhui on 2017/8/7.
//  Copyright © 2017年 kyson. All rights reserved.
//

#import "MDSModel.h"








@interface MDSData :  MDSModel

CREATE_STRING_PROPERTY(zipDownloadUrl)
CREATE_STRING_PROPERTY(version)


@end


@interface WMVer : MDSModel


CREATE_STRING_PROPERTY(errorMsg)
CREATE_STRING_PROPERTY(code)

@property (nonatomic, strong) NSArray<MDSData *> *data;



/**
 * json is like:
 {"errorMsg": "", "code": 0, "data": [{"zipDownloadUrl": "http://www.kyson.cn/demo/watermelon.zip", "version": "1.0.0", "packageName": "watermelon"}]}
 
 */
+(WMVer *) verWithVerJson:(NSString *) verJson;


-(BOOL) versionIsEqualto:(WMVer *)ver;

@end
