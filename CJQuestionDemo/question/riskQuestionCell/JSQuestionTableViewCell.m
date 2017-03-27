//
//  JSQuestionTableViewCell.m
//  mobip2p
//
//  Created by ccj on 17/1/12.
//  Copyright © 2017年 fhjf. All rights reserved.
//

#import "JSQuestionTableViewCell.h"

@implementation JSQuestionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    [self.questionA addTarget:self action:@selector(questionABtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.questionABtn addTarget:self action:@selector(questionABtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.questionB addTarget:self action:@selector(questionBBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.questionBBtn addTarget:self action:@selector(questionBBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.questionC addTarget:self action:@selector(questionCBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.questionCBtn addTarget:self action:@selector(questionCBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.questionD addTarget:self action:@selector(questionDBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.questionDBtn addTarget:self action:@selector(questionDBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.questionEBtn addTarget:self action:@selector(questionEBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.questionEBtn addTarget:self action:@selector(questionEBtnClick:) forControlEvents:UIControlEventTouchUpInside];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
//    if (selected == YES)
//    {
//        for (UIButton *btn in self.btnArr)
//        {
//            if (btn.selected == YES)
//            {
//                NSInteger index = [self.btnArr indexOfObject:btn];
//                if (index == 0)
//                {
//                    [self questionABtnClick:nil];
//                }else if (index == 1)
//                {
//                    [self questionBBtnClick:nil];
//                }else if (index == 2)
//                {
//                    [self questionCBtnClick:nil];
//                }else if (index == 3)
//                {
//                    [self questionDBtnClick:nil];
//                }else if (index == 4)
//                {
//                    [self questionDBtnClick:nil];
//                }
//            }
//        }
//    }

}


- (void)setRiskModel:(JSRiskEvaluateModel *)riskModel
{
    _riskModel = riskModel;
   
    self.questionTitle.text = riskModel.questionTitle;
    self.scoreA = riskModel.scoreA;
    self.scoreB = riskModel.scoreB;
    self.scoreC = riskModel.scoreC;
    self.scoreD = riskModel.scoreD;
    self.scoreE = riskModel.scoreE;

    self.questionALabel.text = riskModel.questionA;
    self.questionBLabel.text = riskModel.questionB;
    self.questionCLabel.text = riskModel.questionC;
    self.questionDLabel.text = riskModel.questionD;
    if (riskModel.questionE)
    {
        self.questionEBtn.hidden = NO;
        self.questionE.hidden = NO;
        self.questionELabel.hidden = NO;
        self.questionELabel.text = riskModel.questionE;
        self.questionE.enabled = NO;
        self.questionEBtn.enabled = NO;

    }else
    {
        self.questionEBtn.hidden = YES;
        self.questionE.hidden = YES;
        self.questionELabel.hidden = YES;
        self.questionE.enabled = YES;
        self.questionEBtn.enabled = YES;
    }
//    for (UIButton *btn in self.) {
//        <#statements#>
//    }
    
    self.btnArr = [NSMutableArray arrayWithObjects:_questionABtn,_questionBBtn,_questionCBtn,_questionDBtn,_questionEBtn, nil];
    [self.allBtnArr addObject:self.btnArr];
    self.scoreArr = [NSMutableArray arrayWithObjects:@(_scoreA),@(_scoreB),@(_scoreC),@(_scoreD),@(_scoreE), nil];
    [self.allScoreArr addObject:self.scoreArr];
    
    self.btnImage.hidden = YES;

    NSLog(@"self.allBtnArr.count = %ld",self.allBtnArr.count);
    NSLog(@"self.index = %d", self.index);
}


- (void)questionABtnClick:(UIButton *)button
{
//    self.questionABtn.selected = !self.questionABtn.selected;
    self.questionABtn.selected = YES;
    self.questionBBtn.selected = NO;
    self.questionCBtn.selected = NO;
    self.questionDBtn.selected = NO;
    self.questionEBtn.selected = NO;
    [self.questionABtn setImage:[UIImage imageNamed:@"icon_a"] forState:UIControlStateSelected];
    
    [self.questionBBtn setImage:[UIImage imageNamed:@"icon_b_on"] forState:UIControlStateNormal];
    [self.questionCBtn setImage:[UIImage imageNamed:@"icon_c_on"] forState:UIControlStateNormal];
    [self.questionDBtn setImage:[UIImage imageNamed:@"icon_d_on"] forState:UIControlStateNormal];
    [self.questionEBtn setImage:[UIImage imageNamed:@"icon_e_on"] forState:UIControlStateNormal];
    
    NSInteger index = [self.btnArr indexOfObject:self.questionABtn];
    if ([self.celldelegate respondsToSelector:@selector(addTager:)]) {
        [self.celldelegate addTager:self.questionABtn];
    }
}

- (void)questionBBtnClick:(UIButton *)button
{
//    self.questionBBtn.selected = !self.questionBBtn.selected;
    self.questionBBtn.selected = YES;
    self.questionABtn.selected = NO;
    self.questionCBtn.selected = NO;
    self.questionDBtn.selected = NO;
    self.questionEBtn.selected = NO;
    [self.questionBBtn setImage:[UIImage imageNamed:@"icon_b"] forState:UIControlStateSelected];
    [self.questionABtn setImage:[UIImage imageNamed:@"icon_a_on"] forState:UIControlStateNormal];
    [self.questionCBtn setImage:[UIImage imageNamed:@"icon_c_on"] forState:UIControlStateNormal];
    [self.questionDBtn setImage:[UIImage imageNamed:@"icon_d_on"] forState:UIControlStateNormal];
    [self.questionEBtn setImage:[UIImage imageNamed:@"icon_e_on"] forState:UIControlStateNormal];
    [self.btnArr removeAllObjects];
}

- (void)questionCBtnClick:(UIButton *)button
{
//    self.questionCBtn.selected = !self.questionCBtn.selected;
    self.questionCBtn.selected = YES;
    self.questionBBtn.selected = NO;
    self.questionABtn.selected = NO;
    self.questionDBtn.selected = NO;
    self.questionEBtn.selected = NO;
    [self.questionCBtn setImage:[UIImage imageNamed:@"icon_c"] forState:UIControlStateSelected];
    [self.questionBBtn setImage:[UIImage imageNamed:@"icon_b_on"] forState:UIControlStateNormal];
    [self.questionABtn setImage:[UIImage imageNamed:@"icon_a_on"] forState:UIControlStateNormal];
    [self.questionDBtn setImage:[UIImage imageNamed:@"icon_d_on"] forState:UIControlStateNormal];
    [self.questionEBtn setImage:[UIImage imageNamed:@"icon_e_on"] forState:UIControlStateNormal];
    [self.btnArr removeAllObjects];
}
- (void)questionDBtnClick:(UIButton *)button
{
    self.questionDBtn.selected = YES;
    self.questionBBtn.selected = NO;
    self.questionCBtn.selected = NO;
    self.questionABtn.selected = NO;
    self.questionEBtn.selected = NO;
    [self.questionDBtn setImage:[UIImage imageNamed:@"icon_d"] forState:UIControlStateSelected];
    [self.questionBBtn setImage:[UIImage imageNamed:@"icon_b_on"] forState:UIControlStateNormal];
    [self.questionCBtn setImage:[UIImage imageNamed:@"icon_c_on"] forState:UIControlStateNormal];
    [self.questionABtn setImage:[UIImage imageNamed:@"icon_a_on"] forState:UIControlStateNormal];
    [self.questionEBtn setImage:[UIImage imageNamed:@"icon_e_on"] forState:UIControlStateNormal];
    [self.btnArr removeAllObjects];
}
- (void)questionEBtnClick:(UIButton *)button
{
    self.questionEBtn.selected = YES;
    self.questionBBtn.selected = NO;
    self.questionCBtn.selected = NO;
    self.questionDBtn.selected = NO;
    self.questionABtn.selected = NO;
    [self.questionEBtn setImage:[UIImage imageNamed:@"icon_a"] forState:UIControlStateSelected];
    [self.questionBBtn setImage:[UIImage imageNamed:@"icon_b_on"] forState:UIControlStateNormal];
    [self.questionCBtn setImage:[UIImage imageNamed:@"icon_c_on"] forState:UIControlStateNormal];
    [self.questionDBtn setImage:[UIImage imageNamed:@"icon_d_on"] forState:UIControlStateNormal];
    [self.questionABtn setImage:[UIImage imageNamed:@"icon_a_on"] forState:UIControlStateNormal];
    [self.btnArr removeAllObjects];
 }

- (IBAction)questionBtnClick:(UIButton *)sender
{
    self.btnImage.hidden = NO;
    self.btnImage.center = CGPointMake(self.btnImage.center.x, sender.center.y);
    if ([self.celldelegate respondsToSelector:@selector(addTager:)]) {
        [self.celldelegate addTager:sender];
    }

}

- (void)setMark:(NSString *)mark
{
    if ([mark isEqualToString:@"0"]) {
        self.btnImage.hidden = YES;
        
    }else if ([mark isEqualToString:@"1"])
    {
        self.btnImage.hidden = NO;
        self.btnImage.center = CGPointMake(self.btnImage.center.x, self.questionABtn.center.y);
    }else if ([mark isEqualToString:@"2"])
    {
        self.btnImage.hidden = NO;
        self.btnImage.center = CGPointMake(self.btnImage.center.x, self.questionBBtn.center.y);
    }else if ([mark isEqualToString:@"3"])
    {
        self.btnImage.hidden = NO;
        self.btnImage.center = CGPointMake(self.btnImage.center.x, self.questionCBtn.center.y);
    }else if ([mark isEqualToString:@"4"])
    {
        self.btnImage.hidden = NO;
        self.btnImage.center = CGPointMake(self.btnImage.center.x, self.questionDBtn.center.y);
    }else if ([mark isEqualToString:@"5"])
    {
        self.btnImage.hidden = NO;
        self.btnImage.center = CGPointMake(self.btnImage.center.x, self.questionEBtn.center.y);
    }
}



@end
