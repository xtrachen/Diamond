//
//  NSObject+XDDictionaryAdapter.h
//  Diamond
//
//  Created by Xtra on 2019/12/31.
//  Copyright © 2019 XtraSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (XDDictionaryAdapter)

- (id)objectForKey:(NSString *)aKey defaultValue:(id)value;
- (NSString *)stringForKey:(NSString *)aKey defaultValue:(NSString *)value;
- (NSArray *)arrayForKey:(NSString *)aKey defaultValue:(NSArray *)value;
- (NSDictionary *)dictionaryForKey:(NSString *)aKey defaultValue:(NSDictionary *)value;
- (NSData *)dataForKey:(NSString *)aKey defaultValue:(NSData *)value;
- (NSUInteger)unsignedIntegerForKey:(NSString *)aKey defaultValue:(NSUInteger)value;
- (NSInteger)integerForKey:(NSString *)aKey defaultValue:(NSInteger)value;
- (float)floatForKey:(NSString *)aKey defaultValue:(float)value;
- (double)doubleForKey:(NSString *)aKey defaultValue:(double)value;
- (long long)longLongValueForKey:(NSString *)aKey defaultValue:(long long)value;
- (BOOL)boolForKey:(NSString *)aKey defaultValue:(BOOL)value;
- (NSDate *)dateForKey:(NSString *)aKey defaultValue:(NSDate *)value;
- (NSNumber *)numberForKey:(NSString *)aKey defaultValue:(NSNumber *)value;
- (int)intForKey:(NSString *)aKey defaultValue:(int)value;

@end

NS_ASSUME_NONNULL_END
