//
//  JSRiskEvaluateAlertView.h
//  mobip2p
//
//  Created by ccj on 17/1/12.
//  Copyright © 2017年 fhjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class JSRiskEvaluateAlertView;

@protocol JSRiskEvaluateAlertViewDelegate <NSObject>

@optional
- (void)dismissBtnClicked:(UIButton *)dismissBtn;

@end

@interface JSRiskEvaluateAlertView : UIView

/** 代理对象 */
@property (nonatomic, weak) id<JSRiskEvaluateAlertViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *RiskAlertView;

@property (weak, nonatomic) IBOutlet UIButton *gotoEvaluateBtn;
@property (weak, nonatomic) IBOutlet UIButton *noRiskBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
// RiskAlertView的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *riskAlertHeight;
// RiskAlertView中底部灰色View 的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomAlertHeight;
@property (weak, nonatomic) IBOutlet UIButton *dismissBtn;

@property (nonatomic, assign) CGFloat AlertViewHeight;
@property (nonatomic, assign) CGFloat AlertViewHeight1;
@property (nonatomic, copy) NSMutableString  *alertValue;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@end
