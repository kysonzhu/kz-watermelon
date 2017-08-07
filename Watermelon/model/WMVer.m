//
//  WMVer.m
//  Watermelon
//
//  Created by zhujinhui on 2017/8/7.
//  Copyright © 2017年 kyson. All rights reserved.
//

#import "WMVer.h"

#import "WMJsonHandler.h"


@implementation MDSData


@end

@implementation WMVer

SETARRAYPROPERTY(MDSData, data, Data)





+(WMVer *)verWithVerJson:(NSString *)verJson {
    
    NSObject *dicObj = [WMJsonHandler jsonObjectWithString:verJson];
    if ([dicObj isKindOfClass:[NSDictionary class]]) {
        WMVer *ver = [[WMVer alloc] init];
        [ver loadPropertiesWithData:(NSDictionary *)dicObj];
        
        return ver;
    }

    return nil;
}




-(BOOL) versionIsEqualto:(WMVer *)ver {
    if (!ver) {
        return NO;
    }
    
    if ([self.data.firstObject.version isEqualToString:ver.data.firstObject.version]) {
        
        return YES;
    }
    
    return NO;
}



@end
