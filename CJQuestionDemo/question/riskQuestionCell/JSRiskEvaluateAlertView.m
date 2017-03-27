//
//  JSRiskEvaluateAlertView.m
//  mobip2p
//
//  Created by ccj on 17/1/12.
//  Copyright © 2017年 fhjf. All rights reserved.
//

#import "JSRiskEvaluateAlertView.h"
#import "UIView+CCJExtension.h"
#define kBootomViewY 10
#define kAlertViewY 85
#define kNormalAlertViewY 100
#define kResultAlertViewY 170
@implementation JSRiskEvaluateAlertView

- (void)layoutSubviews
{
    self.textLabel.hidden = YES;
    self.RiskAlertView.layer.cornerRadius = 10;
    self.RiskAlertView.layer.masksToBounds = YES;
    self.gotoEvaluateBtn.layer.cornerRadius = 15;
    
    /**
     *  1 为首页提示框, 2 为风险评估页面测试结果弹框 3 为员工贷感谢提示框,  4 为标的详情风险提示框
     */
    if ([self.alertValue isEqualToString:@"1"])
    {
        [self setRiskAlertViewHeight1];
    }else if ([self.alertValue isEqualToString:@"2"])
    {
        [self setRiskAlertViewHeight2];
    }else if ([self.alertValue isEqualToString:@"3"])
    {
        [self setRiskAlertViewHeight3];
    }else if ([self.alertValue isEqualToString:@"4"])
    {
        [self setRiskAlertViewHeight4];
    }else if ([self.alertValue isEqualToString:@"5"])
    {
        [self setRiskAlertViewHeight5];
    }else if ([self.alertValue isEqualToString:@"6"])
    {
        [self setRiskAlertViewHeight6];
    }else if ([self.alertValue isEqualToString:@"7"])
    {
        [self setRiskAlertViewHeight7];
    }
    
}

- (void)setRiskAlertViewHeight1
{
    self.bottomAlertHeight.constant = 3 * kBootomViewY + 2 * self.gotoEvaluateBtn.height;
    self.riskAlertHeight.constant =  kAlertViewY + self.bottomAlertHeight.constant;
    
}

- (void)setRiskAlertViewHeight2
{
    self.noRiskBtn.hidden = YES;
    self.noRiskBtn.height = 0;
    self.bottomAlertHeight.constant = 2 * kBootomViewY + self.gotoEvaluateBtn.height;
    self.riskAlertHeight.constant = self.bottomAlertHeight.constant + kAlertViewY;
//    self.riskAlertHeight.constant = self.bottomAlertHeight.constant + kResultAlertViewY;
    
}

- (void)setRiskAlertViewHeight3
{
    self.bottomAlertHeight.constant = 3 * kBootomViewY + 2 * self.gotoEvaluateBtn.height;
    self.riskAlertHeight.constant =  kNormalAlertViewY + 5 * kBootomViewY;
    self.textLabel.hidden = NO;
}

- (void)setRiskAlertViewHeight4
{
    self.bottomAlertHeight.constant = 3 * kBootomViewY + 2 * self.gotoEvaluateBtn.height;
    self.riskAlertHeight.constant =  kAlertViewY + self.bottomAlertHeight.constant;
}
- (void)setRiskAlertViewHeight5
{
    self.noRiskBtn.hidden = YES;
    self.noRiskBtn.height = 0;
    self.bottomAlertHeight.constant = 2 * kBootomViewY + self.gotoEvaluateBtn.height;
    self.riskAlertHeight.constant = self.bottomAlertHeight.constant + kAlertViewY + 10;
}
- (void)setRiskAlertViewHeight6
{
    self.noRiskBtn.hidden = YES;
    self.noRiskBtn.height = 0;
    self.bottomAlertHeight.constant = 2 * kBootomViewY + self.gotoEvaluateBtn.height;
    self.riskAlertHeight.constant = self.bottomAlertHeight.constant + kResultAlertViewY;
}
- (void)setRiskAlertViewHeight7
{
    self.noRiskBtn.hidden = YES;
    self.noRiskBtn.height = 0;
    self.bottomAlertHeight.constant = 2 * kBootomViewY + self.gotoEvaluateBtn.height;
    self.riskAlertHeight.constant = self.bottomAlertHeight.constant + kAlertViewY + 40;}



- (IBAction)RemovewAlertView:(id)sender
{

    // 通知代理（调用代理的方法）
    // respondsToSelector:能判断某个对象是否实现了某个方法
    if ([self.delegate respondsToSelector:@selector(dismissBtnClicked:)]) {
        [self.dismissBtn setSelected:YES];
        [self.delegate dismissBtnClicked:self.dismissBtn];
    }
    [self removeFromSuperview];
}
- (IBAction)noRiskEvaluate:(id)sender
{
    
}
@end
