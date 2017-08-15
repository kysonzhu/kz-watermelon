//
//  WMBIOS.h
//  Watermelon
//
//  Created by kyson on 2017/8/8.
//  Copyright © 2017年 kyson. All rights reserved.
//

#import <Foundation/Foundation.h>


///枚举：logo位置
typedef enum {
    WMBootModeBasicModule = 0, //Basic module,including local package but no url cache system
    WMBootModeUpdateModule,   // Update model,no using local package and url cache system but has network
    WMBootModeAllModule      //All in,including local package,url cache,network
} WMBootMode;

typedef void(^BootModeSuccess)(WMBootMode bootMode);

/**
 * Like PC BIOS,this class provide self-inspection of system
 */

@interface WMBIOS : NSObject




/**
 * new sigleton instance
 */
+(WMBIOS *) shareInstance ;


/**
 * start BIOS and basic mode finished
 */
- (void) startFinishBasicMode:(BootModeSuccess) success;


/**
 * switch mode to specific mode
 */
-(void)switchToMode:(WMBootMode) mode;


@end
