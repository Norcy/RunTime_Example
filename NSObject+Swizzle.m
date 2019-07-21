//
//  NSObject+Swizzle.m
//  RunTime
//
//  Created by Norcy on 2019/7/21.
//  Copyright © 2019年 Norcy. All rights reserved.
//

#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector)
{
    // 获取 Method
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    // 确保这两个方法一定存在（要么在本类，要么在其父类里）
    if (originalMethod && swizzledMethod)
    {
        // 如果本类没有 origin 方法，则给 originalSelector 添加 swizzled 实现（origin 方法在父类，因为 originalMethod 不为空），返回 YES
        // 如果本类有 origin 方法，则添加失败，返回 NO
        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod)
        {
            // 添加成功，表示已实现 originalSelector -> swizzledIMP
            // 接下来实现 swizzledSelector -> originalIMP
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }
        else
        {
            // 添加失败，表示类里原本就有 originalIMP，只需要交换这两个方法的实现即可
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    }
}

@implementation NSObject (Swizzle)

@end
