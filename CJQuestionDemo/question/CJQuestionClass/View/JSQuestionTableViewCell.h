//
//  JSQuestionTableViewCell.h
//  mobip2p
//
//  Created by ccj on 17/1/12.
//  Copyright © 2017年 fhjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSRiskEvaluateModel.h"
@protocol cellDelegate <NSObject>

-(void)addTager:(UIButton *)sender;

@end
@interface JSQuestionTableViewCell : UITableViewCell
@property (nonatomic, strong)JSRiskEvaluateModel *riskModel;

@property (nonatomic, weak)IBOutlet UILabel *questionTitle;
@property (nonatomic, assign)int scoreA;
@property (nonatomic, assign)int scoreB;
@property (nonatomic, assign)int scoreC;
@property (nonatomic, assign)int scoreD;
@property (nonatomic, assign)int scoreE;
@property (weak, nonatomic) IBOutlet UIButton *questionA;
@property (weak, nonatomic) IBOutlet UIButton *questionB;
@property (weak, nonatomic) IBOutlet UIButton *questionC;
@property (weak, nonatomic) IBOutlet UIButton *questionD;
@property (weak, nonatomic) IBOutlet UIButton *questionE;
@property (weak, nonatomic) IBOutlet UIButton *questionABtn;
@property (weak, nonatomic) IBOutlet UIButton *questionBBtn;
@property (weak, nonatomic) IBOutlet UIButton *questionCBtn;
@property (weak, nonatomic) IBOutlet UIButton *questionDBtn;
@property (weak, nonatomic) IBOutlet UIButton *questionEBtn;
@property (weak, nonatomic) IBOutlet UILabel *questionALabel;
@property (weak, nonatomic) IBOutlet UILabel *questionBLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionCLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionDLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionELabel;
@property (weak, nonatomic) IBOutlet UIImageView *btnImage;

@property (strong, nonatomic) NSMutableArray *btnArr;
@property (strong, nonatomic) NSMutableArray *allBtnArr;
@property (strong, nonatomic) NSMutableArray *scoreArr;
@property (strong, nonatomic) NSMutableArray *allScoreArr;

@property (nonatomic, assign)int index;
@property(nonatomic,weak)id<cellDelegate>celldelegate;

- (void)setMark:(NSString *)mark;

@end
