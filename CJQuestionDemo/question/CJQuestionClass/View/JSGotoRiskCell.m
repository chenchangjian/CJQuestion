//
//  JSGotoRiskCell.m
//  mobip2p
//
//  Created by ccj on 17/1/12.
//  Copyright © 2017年 fhjf. All rights reserved.
//

#import "JSGotoRiskCell.h"

@implementation JSGotoRiskCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    [self.questionBtn setUserInteractionEnabled:NO];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRiskModel:(JSRiskEvaluateModel *)riskModel
{
    _riskModel = riskModel;
}

@end
