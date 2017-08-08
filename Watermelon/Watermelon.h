//
//  Watermelon.h
//  Watermelon
//
//  Created by zhujinhui on 2017/8/5.
//  Copyright © 2017年 kyson. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WMBIOS.h"


@interface Watermelon : NSObject


/**
 * current boot mode
 */
@property (nonatomic, readonly) WMBootMode currentBootMode;

+(Watermelon *) shareInstance ;



/**
 * register service
 */
+(void) registeWatermelonService;






@end
