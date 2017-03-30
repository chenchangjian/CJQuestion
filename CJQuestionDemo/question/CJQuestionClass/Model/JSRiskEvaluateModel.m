//
//  JSRiskEvaluateModel.m
//  mobip2p
//
//  Created by ccj on 17/1/12.
//  Copyright © 2017年 fhjf. All rights reserved.
//

#import "JSRiskEvaluateModel.h"
// 间距
#define kCCJConmentX 10
// 每行的高度(包括竖直方向间距)
#define kCCJConmentY 34
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
@implementation JSRiskEvaluateModel
#pragma mark - 设定了cell的高度和图片的frame
- (CGFloat)cellHeight
{
    CGFloat textW = kScreenW - 2 * kCCJConmentX;
    CGFloat textH = [self.questionTitle boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;

    if (_questionE)
    {
        _cellHeight = textH + 2 * kCCJConmentX + kCCJConmentY * 5;
    }else
    {
        _cellHeight = textH + 2 * kCCJConmentX + kCCJConmentY * 4;
    }
    
    return _cellHeight;
}

- (CGFloat)cellHeight1
{
    CGFloat textW = kScreenW - 2 * kCCJConmentX;
    CGFloat textH = [self.questionTitle boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
//    if (_questionE)
//    {
//        _cellHeight = textH + 2 * kCCJConmentX + kCCJConmentY * 5;
//    }else
//    {
//        _cellHeight = textH + 2 * kCCJConmentX + kCCJConmentY * 4;
//    }
    
    _cellHeight1 = textH + 2 * kCCJConmentX;
    
    return _cellHeight1;

}
@end
