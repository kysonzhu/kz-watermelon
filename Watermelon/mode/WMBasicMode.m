//
//  BasicMode.m
//  Watermelon
//
//  Created by kyson on 2017/8/15.
//  Copyright © 2017年 kyson. All rights reserved.
//

#import "WMBasicMode.h"

#import "WMPackageManager.h"

#import "Watermelon.h"

@implementation WMBasicMode

-(void)start {
    
    if (![WMPackageManager isPackageExists]) {
        [WMPackageManager installLocalPackage];
        //post notification
        [[NSNotificationCenter defaultCenter] postNotificationName:WatermelonNotificationModeSettingFinished object:nil];
    }
}


-(void)stop {
    
    
}



@end
