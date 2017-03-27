//
//  JSGotoRiskCell.h
//  mobip2p
//
//  Created by ccj on 17/1/12.
//  Copyright © 2017年 fhjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSRiskEvaluateModel.h"
@interface JSGotoRiskCell : UITableViewCell
@property (nonatomic, strong) JSRiskEvaluateModel *riskModel;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UIButton *questionBtn;
@property (weak, nonatomic) IBOutlet UIView *line;
@end
