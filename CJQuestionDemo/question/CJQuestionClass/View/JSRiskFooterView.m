//
//  JSRiskFooterView.m
//  mobip2p
//
//  Created by ccj on 17/1/12.
//  Copyright © 2017年 fhjf. All rights reserved.
//
#import "JSRiskFooterView.h"

@implementation JSRiskFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib
{
    _commitView.layer.cornerRadius = 10.0;
    self.comeInSelectBtn.selected = YES;
    self.commitBtn.layer.cornerRadius = 5.0;
}
- (IBAction)selectBtnNomal:(id)sender
{
    self.comeInSelectBtn.selected = !self.comeInSelectBtn.selected;
//    if (self.comeInSelectBtn.selected == NO)
//    {
//        self.commitView.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
//        [self.commitBtn setEnabled:NO];
//        self.textLabel.textColor = [UIColor blackColor];
//    }else
//    {
//        self.commitView.backgroundColor = UIColorFromRGB(0xFE3509);
//        [self.commitBtn setEnabled:YES];
//        self.textLabel.textColor = [UIColor whiteColor];
//
//    }
}

@end
