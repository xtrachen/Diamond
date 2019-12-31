//
//  NSObject+XDDictionaryAdapter.m
//  Diamond
//
//  Created by Xtra on 2019/12/31.
//  Copyright © 2019 XtraSoft. All rights reserved.
//

#import "NSObject+XDDictionaryAdapter.h"

@implementation NSObject (XDDictionaryAdapter)




#pragma mark - Wrap for objectForKey:aKey
- (id)objectForKey:(NSString *)aKey defaultValue:(id)value
{
    if ([self respondsToSelector:@selector(objectForKey:)]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-method-access"
        id obj = [(NSDictionary *)self objectForKey:aKey];
#pragma clang diagnostic pop
        
        return (obj && obj != [NSNull null]) ? obj : value;
    }
    
#if DEBUG
    else {
        NSLog(@"Error, called function %s with illegal parameters, The key is:%@, The value is:%@", __func__, aKey, value);
        [self printCurrentCallStack];
        
        NSString *reason = [NSString stringWithFormat:@"The key is %@, the value is :%@", aKey, value];
        NSException *exception = [NSException exceptionWithName:@"IllegalParameters" reason:reason userInfo:(NSDictionary *)self];
        @throw exception;
        
        return nil;
    }
#endif
    return nil;
}

- (void)printCurrentCallStack
{
    NSArray *callArray = [NSThread callStackSymbols];
    NSLog(@"\n -----------------------------------------call stack----------------------------------------------\n");
    for (NSString *string in callArray) {
        NSLog(@"  %@  ", string);
    }
    NSLog(@"\n -------------------------------------------------------------------------------------------------\n");
}
// [[NSNull null] isKindOfClass:[NSString class]] 不会崩溃，调用结果是返回0
- (NSString *)stringForKey:(NSString *)aKey defaultValue:(NSString *)value
{
    id obj = [self objectForKey:aKey defaultValue:value];
    if (![obj isKindOfClass:[NSString class]]) {
#if DEBUG
        if (obj) {
            NSLog(@"Error, %s obj is not kind of Class NSString, The key is:%@", __func__, aKey);
            [self printCurrentCallStack];
            
            NSString *reason = [NSString stringWithFormat:@"The key is %@, the value is :%@", aKey, value];
            NSException *exception = [NSException exceptionWithName:@"IllegalType" reason:reason userInfo:(NSDictionary *)self];
            @throw exception;
        }
#endif
        return value;
    }
    
    return (NSString *)obj;
}

- (NSArray *)arrayForKey:(NSString *)aKey defaultValue:(NSArray *)value
{
    id obj = [self objectForKey:aKey defaultValue:value];
    if (![obj isKindOfClass:[NSArray class]]) {
#if DEBUG
        if (obj) {
            NSLog(@"Error, %s obj is not kind of Class NSArray, The key is:%@", __func__, aKey);
            [self printCurrentCallStack];
            
            NSString *reason = [NSString stringWithFormat:@"The key is %@, the value is :%@", aKey, value];
            NSException *exception = [NSException exceptionWithName:@"IllegalType" reason:reason userInfo:(NSDictionary *)self];
            @throw exception;
        }
#endif
        return value;
    }
    
    return (NSArray *)obj;
}

- (NSDictionary *)dictionaryForKey:(NSString *)aKey defaultValue:(NSDictionary *)value
{
    id obj = [self objectForKey:aKey defaultValue:value];
    if (![obj isKindOfClass:[NSDictionary class]]) {
#if DEBUG
        if (obj) {
            NSLog(@"Error, %s obj is not kind of Class NSDictionary, The key is:%@", __func__, aKey);
            [self printCurrentCallStack];
            
            NSString *reason = [NSString stringWithFormat:@"The key is %@, the value is :%@", aKey, value];
            NSException *exception = [NSException exceptionWithName:@"IllegalType" reason:reason userInfo:(NSDictionary *)self];
            @throw exception;
        }
#endif
        return value;
    }
    
    return (NSDictionary *)obj;
}

- (NSData *)dataForKey:(NSString *)aKey defaultValue:(NSData *)value
{
    id obj = [self objectForKey:aKey defaultValue:value];
    if (![obj isKindOfClass:[NSData class]]) {
#if DEBUG
        if (obj) {
            NSLog(@"Error, %s obj is not kind of Class NSData, The key is:%@", __func__, aKey);
            [self printCurrentCallStack];
            
            NSString *reason = [NSString stringWithFormat:@"The key is %@, the value is :%@", aKey, value];
            NSException *exception = [NSException exceptionWithName:@"IllegalType" reason:reason userInfo:(NSDictionary *)self];
            @throw exception;
        }
#endif
        return value;
    }
    
    return (NSData *)obj;
}

- (NSDate *)dateForKey:(NSString *)aKey defaultValue:(NSDate *)value
{
    id obj = [self objectForKey:aKey defaultValue:value];
    if (![obj isKindOfClass:[NSDate class]]) {
#if DEBUG
        if (obj) {
            NSLog(@"Error, %s obj is not kind of Class NSDate, The key is:%@", __func__, aKey);
            [self printCurrentCallStack];
            
            NSString *reason = [NSString stringWithFormat:@"The key is %@, the value is :%@", aKey, value];
            NSException *exception = [NSException exceptionWithName:@"IllegalType" reason:reason userInfo:(NSDictionary *)self];
            @throw exception;
        }
#endif
        return value;
    }
    
    return (NSDate *)obj;
}

- (NSNumber *)numberForKey:(NSString *)aKey defaultValue:(NSNumber *)value
{
    id obj = [self objectForKey:aKey defaultValue:value];
    if (![obj isKindOfClass:[NSNumber class]]) {
#if DEBUG
        if (obj) {
            NSLog(@"Error, %s obj is not kind of Class NSNumber, The key is:%@", __func__, aKey);
            [self printCurrentCallStack];
            
            NSString *reason = [NSString stringWithFormat:@"The key is %@, the value is :%@", aKey, value];
            NSException *exception = [NSException exceptionWithName:@"IllegalType" reason:reason userInfo:(NSDictionary *)self];
            @throw exception;
        }
#endif
        return value;
    }
    
    return (NSNumber *)obj;
}

- (NSUInteger)unsignedIntegerForKey:(NSString *)aKey defaultValue:(NSUInteger)value
{
    //lly 7,25 去掉不必要的验证
    id obj = [self objectForKey:aKey defaultValue:nil];
    if ([obj respondsToSelector:@selector(unsignedIntegerValue)]) {
        return [obj unsignedIntegerValue];
    }
    
    return value;
}

- (int)intForKey:(NSString *)aKey defaultValue:(int)value
{
    id obj = [self objectForKey:aKey defaultValue:nil];
    if ([obj respondsToSelector:@selector(intValue)]) {
        return [obj intValue];
    }
    
    return value;
}

- (NSInteger)integerForKey:(NSString *)aKey defaultValue:(NSInteger)value
{
    id obj = [self objectForKey:aKey defaultValue:nil];
    if ([obj respondsToSelector:@selector(integerValue)]) {
        return [obj integerValue];
    }
    
    return value;
}

- (float)floatForKey:(NSString *)aKey defaultValue:(float)value
{
    id obj = [self objectForKey:aKey defaultValue:nil];
    if ([obj respondsToSelector:@selector(floatValue)]) {
        return [obj floatValue];
    }
    
    return value;
}

- (double)doubleForKey:(NSString *)aKey defaultValue:(double)value
{
    id obj = [self objectForKey:aKey defaultValue:nil];
    if ([obj respondsToSelector:@selector(doubleValue)]) {
        return [obj doubleValue];
    }
    
    return value;
}

- (long long)longLongValueForKey:(NSString *)aKey defaultValue:(long long)value
{
    id obj = [self objectForKey:aKey defaultValue:nil];
    if ([obj respondsToSelector:@selector(longLongValue)]) {
        return [obj longLongValue];
    }
    
    return value;
}

- (BOOL)boolForKey:(NSString *)aKey defaultValue:(BOOL)value
{
    id obj = [self objectForKey:aKey defaultValue:nil];
    if ([obj respondsToSelector:@selector(boolValue)]) {
        return [obj boolValue];
    }
    
    return value;
}

#pragma mark - Wrap for setObject:value forKey:aKey
- (void)setObjectSafe:(id)value forKey:(id)aKey
{
    if (!value || !aKey || value == [NSNull null] || aKey == [NSNull null]) {
        //        DLog(DT_all, @"nil value(%@) or key(%@)", value, aKey);
        return;
    }
    
    if ([self respondsToSelector:@selector(setObject:forKey:)]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-method-access"
        [(NSMutableDictionary *)self setObject:value forKey:aKey];
#pragma clang diagnostic pop
    }
    
#if DEBUG
    else {
        NSLog(@"Error, called function %s with illegal parameters, The key is:%@, The value is:%@", __func__, aKey, value);
        [self printCurrentCallStack];
        
        NSString *reason = [NSString stringWithFormat:@"The key is %@, the value is :%@", aKey, value];
        NSException *exception = [NSException exceptionWithName:@"IllegalParameters" reason:reason userInfo:(NSDictionary *)self];
        @throw exception;
    }
#endif
    
}

//使用这个方法的前提是object肯定满足条件，只对key进行判断,不对外开放只在本类内部使用
- (void)setObject:(id)value forSafeKey:(id)aKey
{
    if (!aKey || aKey == [NSNull null]) {
        return;
    }
    
    if ([self respondsToSelector:@selector(setObject:forKey:)]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-method-access"
        [(NSMutableDictionary *)self setObject:value forKey:aKey];
#pragma clang diagnostic pop
    }
    
#if DEBUG
    else {
        NSLog(@"Error, called function %s with illegal parameters, The key is:%@, The value is:%@", __func__, aKey, value);
        [self printCurrentCallStack];
        
        NSString *reason = [NSString stringWithFormat:@"The key is %@, the value is :%@", aKey, value];
        NSException *exception = [NSException exceptionWithName:@"IllegalParameters" reason:reason userInfo:(NSDictionary *)self];
        @throw exception;
    }
#endif
    
}

- (void)setString:(NSString *)value forKey:(NSString *)aKey
{
    [self setObjectSafe:value forKey:aKey];
}

- (void)setNumber:(NSNumber *)value forKey:(NSString *)aKey
{
    [self setObjectSafe:value forKey:aKey];
}

- (void)setInteger:(NSInteger)value forKey:(NSString *)aKey
{
    [self setObject:[NSNumber numberWithInteger:value] forSafeKey:aKey];
}

- (void)setInt:(int)value forKey:(NSString *)aKey
{
    [self setObject:[NSNumber numberWithInt:value] forSafeKey:aKey];
}

- (void)setFloat:(float)value forKey:(NSString *)aKey
{
    [self setObject:[NSNumber numberWithFloat:value] forSafeKey:aKey];
}

- (void)setDouble:(double)value forKey:(NSString *)aKey
{
    [self setObject:[NSNumber numberWithDouble:value] forSafeKey:aKey];
}

- (void)setLongLongValue:(long long)value forKey:(NSString *)aKey
{
    [self setObject:[NSNumber numberWithLongLong:value] forSafeKey:aKey];
}

- (void)setBool:(BOOL)value forKey:(NSString *)aKey
{
    [self setObject:[NSNumber numberWithBool:value] forSafeKey:aKey];
}


@end
