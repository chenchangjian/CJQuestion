//
//  UIView+CCJExtension.h
//
//  Created by ccj on 15/9/11.
//  Copyright (c) 2015年 ccj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CCJExtension)

// @property在分类里面只会自动生成get,set方法，并不会生成下划线的成员属性
@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat x;

@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat centerX;

@property (nonatomic, assign) CGFloat centerY;

/** 从xib中创建一个控件 */
+ (instancetype)viewFromXib;

@end
