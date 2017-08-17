//
//  WMService.h
//  Watermelon
//
//  Created by kyson on 2017/8/17.
//  Copyright © 2017年 kyson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMService : NSObject

/**
 * service instance create
 */
+ (WMService *) serviceWithURL: (NSURL *) URL;

@end
