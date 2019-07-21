//
//  NSObject+Swizzle.h
//  RunTime
//
//  Created by Norcy on 2019/7/21.
//  Copyright © 2019年 Norcy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector);

@interface NSObject (Swizzle)
@end

NS_ASSUME_NONNULL_END
