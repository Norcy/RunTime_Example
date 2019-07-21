//
//  NSMutableArray+Safe.m
//  RunTime
//
//  Created by Norcy on 2019/7/21.
//  Copyright © 2019年 Norcy. All rights reserved.
//

#import "NSMutableArray+Safe.h"
#import "NSObject+Swizzle.h"

@implementation NSMutableArray (Safe)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzleMethod(NSClassFromString(@"__NSArrayM"), @selector(addObject:), @selector(safe_addObject:));
        swizzleMethod(NSClassFromString(@"__NSArrayM"), @selector(insertObject:atIndex:), @selector(safe_insertObject:atIndex:));
        swizzleMethod(NSClassFromString(@"__NSArrayM"), @selector(removeObjectAtIndex:), @selector(safe_removeObjectAtIndex:));
        swizzleMethod(NSClassFromString(@"__NSArrayM"), @selector(replaceObjectAtIndex:withObject:), @selector(safe_replaceObjectAtIndex:withObject:));
        swizzleMethod(NSClassFromString(@"__NSArrayM"), @selector(objectAtIndex:), @selector(safe_objectAtIndex:));
        swizzleMethod(NSClassFromString(@"__NSArrayM"), @selector(objectAtIndexedSubscript:), @selector(safe_objectAtIndexedSubscript:));
    });
}

- (void)safe_addObject:(id)anObject
{
    if (!anObject)
    {
#ifdef DEBUG
        @throw NSInvalidArgumentException;
#endif
        return;
    }

    [self safe_addObject:anObject];
}

- (void)safe_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (index > [self count] || !anObject)
    {
#ifdef DEBUG
        @throw NSInvalidArgumentException;
#endif
        return;
    }
    
    [self safe_insertObject:anObject atIndex:index];
}

- (void)safe_removeObjectAtIndex:(NSUInteger)index
{
    if (index >= [self count])
    {
#ifdef DEBUG
        @throw NSInvalidArgumentException;
#endif
        return;
    }

    return [self safe_removeObjectAtIndex:index];
}

- (void)safe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if (index >= [self count] || !anObject)
    {
#ifdef DEBUG
        @throw NSInvalidArgumentException;
#endif
        return;
    }
    
    [self safe_replaceObjectAtIndex:index withObject:anObject];
}

- (id)safe_objectAtIndex:(NSUInteger)index
{
    if (index >= [self count])
    {
#ifdef DEBUG
        @throw NSInvalidArgumentException;
#endif
        return nil;
    }
    return [self safe_objectAtIndex:index];
}

// 使用下标访问会调用到这里，e.g. s[1]
- (id)safe_objectAtIndexedSubscript:(NSUInteger)index
{
    if (index >= [self count])
    {
#ifdef DEBUG
        @throw NSInvalidArgumentException;
#endif
        return nil;
    }
    
    return [self safe_objectAtIndexedSubscript:index];
}
@end
