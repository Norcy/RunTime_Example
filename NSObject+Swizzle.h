//
//  NSObject+Swizzle.h
//  RunTime
//
//  Created by Norcy on 2019/7/21.
//  Copyright © 2019年 Norcy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// swizzleMethod 采用 C 函数，而不是 NSObject 的方法，是为了防止子类在 load 方法中向其自己发送消息
// 那样会导致其 +initialize 方法在 load 的时候被提前调用，而此时系统环境是不稳定的
void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector);

@interface NSObject (Swizzle)
@end

NS_ASSUME_NONNULL_END
