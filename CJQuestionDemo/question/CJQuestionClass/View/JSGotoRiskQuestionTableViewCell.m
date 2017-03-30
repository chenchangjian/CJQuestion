//
//  JSGotoRiskQuestionTableViewCell.m
//  mobip2p
//
//  Created by ccj on 17/1/12.
//  Copyright © 2017年 fhjf. All rights reserved.
//

#import "JSGotoRiskQuestionTableViewCell.h"

@implementation JSGotoRiskQuestionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setQuestionTitleStr:(NSString *)questionTitleStr
{
    _questionTitleStr = questionTitleStr;
    self.questionTitle.text = questionTitleStr;
}
@end
