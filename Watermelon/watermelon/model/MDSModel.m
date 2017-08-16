//
//  MDSModel.m
//  BIFCore
//
//  Created by Softwind.Tang on 15/1/7.
//  Copyright (c) 2015年 Plan B Inc. All rights reserved.
//

#import "MDSModel.h"
#import <objc/runtime.h>

#define CStringToNSSting(A) [[NSString alloc] initWithCString:(A) encoding:NSUTF8StringEncoding]

NSString * const kMDSModelPropertyDefaultValue = @"";

@implementation MDSModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

#pragma mark - publics

+ (NSArray *)keyPathInApiResponse
{
    return @[@"items"];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

- (void)loadPropertiesWithData:(NSDictionary *)data
{
    if (![data isKindOfClass:[NSDictionary class]]) {
        NSLog(@"load property error, data is not dictionary: %@", data);
        return;
    }
    
    for (NSString *key in [data keyEnumerator]) {
        //保留字去掉
        if ([key isEqualToString:@"description"]) {
            [self setValue:data[key] forUndefinedKey:key];
            continue;
        }
        
        if ([data[key] isKindOfClass:[NSNull class]]) {
            [self setValue:@"" forUndefinedKey:key];
            continue;
        }
        
        if ([self respondsToSelector:NSSelectorFromString(key)]) {
            NSString *setter = [NSString stringWithFormat:@"set%@%@:",
                                [[key substringToIndex:1] uppercaseString],
                                [key substringFromIndex:1]];
            
            id value = data[key];
            
            [self performSelector:NSSelectorFromString(setter)
                       withObject:value];
        }
    }
}

#pragma clang diagnostic pop

- (NSArray *)loadArrayPropertyWithDataSource:(NSArray *)data requireModel:(NSString *)model
{
    if (![data isKindOfClass:[NSArray class]]) {
        NSLog(@"load array property error, data is not array: %@", data);
        return nil;
    }
    
    NSMutableArray *p = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        MDSModel *m = [[NSClassFromString(model) alloc] init];
        if (![m isKindOfClass:[MDSModel class]]) {
            NSLog(@"load array property error, requireModel [%@] is not subclass of MDSModel", model);
            return nil;
        }
        [m loadPropertiesWithData:dic];
        [p addObject:m];
    }

    return p;
}

#pragma mark - life cycle

- (instancetype)init
{
    if (self = [super init]) {
        [self resetAllValues];
    }
    
    return self;
}

#pragma mark - dictionaryRepresentation

/**
 *  全反射！
 */
- (NSMutableDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i < count; ++ i) {
        NSString *propertyClassName = [self classNameFromType:CStringToNSSting(property_getAttributes(properties[i]))];
        NSString *propertyName = CStringToNSSting(property_getName(properties[i]));
        id propertyValue = [self valueForKey:propertyName];
        
        if (!propertyValue) {
            continue;
        }
        
        //是 MDSModel 的子类
        if ([NSClassFromString(propertyClassName) isSubclassOfClass:[MDSModel class]]) {
            dic[propertyName] = [propertyValue dictionaryRepresentation];
            continue;
        }
        
        //是数组
        if (NSClassFromString(propertyClassName) == [NSArray class]) {
            NSMutableArray *array = [NSMutableArray array];
            for (MDSModel *model in propertyValue) {

                if ([model isKindOfClass:[MDSModel class]]) {
                    NSMutableDictionary *modelDict = [NSMutableDictionary dictionaryWithDictionary:[model dictionaryRepresentation]];
                    
                    [array addObject:modelDict];
                } else {
                    [array addObject:model];
                }
            }
            dic[propertyName] = array;
            continue;
        }
        
        //其他情况
        dic[propertyName] = propertyValue;
    }
    free(properties);//否则内存泄漏

    return dic;
}

#pragma mark - reset values

- (void)resetAllValues
{
    [self resetAllValuesInClass:[self class]];
}

- (void)resetAllValuesInClass:(Class)class
{
    if ([class superclass] != [MDSModel class]) {
        [self resetAllValuesInClass:[class superclass]];
    }
    
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList(class, &count);
    
    
    for (int i = 0; i < count; ++ i) {
        NSString *propertyClassName = [[NSString alloc] initWithCString:property_getAttributes(properties[i])
                                                               encoding:NSUTF8StringEncoding];
        propertyClassName = [self classNameFromType:propertyClassName];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(properties[i])
                                                          encoding:NSUTF8StringEncoding];
        
        if (!propertyClassName) {
            continue;
        }
        
        //是 字符串 （一般属性）
        if ([propertyClassName isEqualToString:@"NSString"]) {
            [self setValue:kMDSModelPropertyDefaultValue
                    forKey:propertyName];
            continue;
        }
        
        //是嵌套类
        if ([NSClassFromString(propertyClassName) isSubclassOfClass:[MDSModel class]]) {
            MDSModel *model = [[NSClassFromString(propertyClassName) alloc] init];
            [self setValue:model
                    forKey:propertyName];
        }
        
    }
    free(properties);//否则内存泄漏

}

- (NSString *)classNameFromType:(NSString *)propertyType
{
    NSArray *array = [propertyType componentsSeparatedByString:@"\""];
    if ([array count] == 3) {
        return array[1];
    } else {
        return nil;
    }
}

@end

