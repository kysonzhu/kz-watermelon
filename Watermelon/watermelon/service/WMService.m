//
//  WMService.m
//  Watermelon
//
//  Created by kyson on 2017/8/17.
//  Copyright © 2017年 kyson. All rights reserved.
//

#import "WMService.h"

@implementation WMService


+ (WMService *) serviceWithURL: (NSURL *) URL {
    WMService *service = [[WMService alloc] init];
    NSString *decodedURLString = [self __URLDecodingWithEncodingString:URL.absoluteString];
    NSLog(@"decodedURLString:%@",decodedURLString);
    
    return service;
    
}



+ (NSString *)__URLDecodingWithEncodingString:(NSString *)encodingString
{
    NSMutableString *string = [NSMutableString stringWithString:encodingString];
    [string replaceOccurrencesOfString:@"+"
                            withString:@" "
                               options:NSLiteralSearch
                                 range:NSMakeRange(0, [string length])];
    return [string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
