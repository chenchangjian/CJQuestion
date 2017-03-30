//
//  JSRiskEvaluateModel.h
//  mobip2p
//
//  Created by ccj on 17/1/12.
//  Copyright © 2017年 fhjf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JSRiskEvaluateModel : NSObject
@property (nonatomic, copy)NSString *questionTitle;
@property (nonatomic, copy)NSString *questionA;
@property (nonatomic, copy)NSString *questionB;
@property (nonatomic, copy)NSString *questionC;
@property (nonatomic, copy)NSString *questionD;
@property (nonatomic, copy)NSString *questionE;
@property (nonatomic, assign)int scoreA;
@property (nonatomic, assign)int scoreB;
@property (nonatomic, assign)int scoreC;
@property (nonatomic, assign)int scoreD;
@property (nonatomic, assign)int scoreE;
/*****额外的属性******/
/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat cellHeight1;
@end
