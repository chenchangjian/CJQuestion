//
//  JSGotoRiskTableViewController.m
//  mobip2p
//
//  Created by ccj on 17/1/12.
//  Copyright © 2017年 fhjf. All rights reserved.
//

#import "JSGotoRiskTableViewController.h"
#import "JSRiskEvaluateModel.h"
#import "MJExtension.h"
//#import "CJNetWorkTools.h"
#import "JSGotoRiskCell.h"
#import "JSGotoRiskQuestionTableViewCell.h"
#import "JSQuestionTableViewCell.h"
#import "UIView+CCJExtension.h"
#import "JSRiskEvaluateAlertView.h"
//#import "CJWebworkTools.h"
//#import "JSFindWebViewController.h"
#import "JSRiskFooterView.h"
// 若引用
#define CCJWeakSelf __weak typeof(self) weakSelf = self;
#define screenW [UIScreen mainScreen].bounds.size.width
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kObjcNull           ((id)[NSNull null])
#define LINESPACE 6


@interface JSGotoRiskTableViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) NSArray       *dataArray; // 装tableViewCell组的数组
@property (nonatomic, strong) JSGotoRiskCell *cell;
@property (nonatomic, assign) int score1;
@property (nonatomic, assign) int score2;
@property (nonatomic, assign) int score3;
@property (nonatomic, assign) int score4;
@property (nonatomic, assign) int score5;
@property (nonatomic, assign) int score6;
@property (nonatomic, assign) int score7;
@property (nonatomic, assign) int score8;
@property (nonatomic, assign) int score9;
@property (nonatomic, assign) int score10;
@property (nonatomic, assign) BOOL score1Bool;
@property (nonatomic, assign) BOOL score2Bool;
@property (nonatomic, assign) BOOL score3Bool;
@property (nonatomic, assign) BOOL score4Bool;
@property (nonatomic, assign) BOOL score5Bool;
@property (nonatomic, assign) BOOL score6Bool;
@property (nonatomic, assign) BOOL score7Bool;
@property (nonatomic, assign) BOOL score8Bool;
@property (nonatomic, assign) BOOL score9Bool;
@property (nonatomic, assign) BOOL score10Bool;

@property (nonatomic, assign) int riskScore;
@property (nonatomic, strong) UIButton *commitBtn;
@property (nonatomic, strong) UIButton *attentMeeting;
@property (nonatomic, strong) NSMutableArray *questionLabelArr;
//@property (nonatomic, strong) NSMutableDictionary *cellMarkDic;
@property (nonatomic, strong) NSMutableArray *cellMarkArray;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger index0;
@property (nonatomic, assign) NSInteger index1;
@property (nonatomic, assign) NSInteger index2;
@property (nonatomic, assign) NSInteger index3;
@property (nonatomic, assign) NSInteger index4;
@property (nonatomic, assign) NSInteger index5;
@property (nonatomic, assign) NSInteger index6;
@property (nonatomic, assign) NSInteger index7;
@property (nonatomic, assign) NSInteger index8;
@property (nonatomic, assign) NSInteger index9;
@property (strong, nonatomic) UIView *RiskAlertView;
@property (nonatomic, strong) JSRiskEvaluateAlertView *nView;

//@property (nonatomic, strong) JSQuestionTableViewCell *cell;

@property (nonatomic, assign) BOOL isAllSelect;
@property (nonatomic, assign) BOOL isNeedPop;
@property (nonatomic, strong) JSRiskFooterView *footview;
@end

static NSString * const question = @"JSGotoRiskCell";
static NSString * const question1 = @"QuestionCell";
static NSString * const questionTitle = @"QuestionTitle";
@implementation JSGotoRiskTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData:YES changeType:NO selectedIndex:1];
    self.title = @"风险评估";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JSGotoRiskCell class]) bundle:nil] forCellReuseIdentifier:question];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JSGotoRiskQuestionTableViewCell class]) bundle:nil] forCellReuseIdentifier:questionTitle];
//    self.tableView.backgroundColor = UIColorFromRGB(0xF8F8F8);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self setCommitBtnAndAttendBtn];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JSQuestionTableViewCell class]) bundle:nil] forCellReuseIdentifier:question1];

//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 96, 0);

    [self setUpFooterViewLabel];
}

- (void)setUpFooterViewLabel
{
    
    JSRiskFooterView *footview = [JSRiskFooterView viewFromXib];
    NSString *text = @"          我同意《投资人入会申请》并确认本次调查反映我的真实意愿，并明确我的投资风险偏好；同时确认经贵公司提醒，我已持有充分的流动资金以应不时之需，已通过该风险测评，可以购买产品。";
    
    NSLog(@"text.length = %lu", (unsigned long)text.length);
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    [paraStyle setLineSpacing:LINESPACE];//调整行间距
    
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:13.0], NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:text attributes:dic];

    // 设置金额字体和颜色
    [attributeStr addAttribute:NSFontAttributeName
                         value:[UIFont systemFontOfSize:13]
                         range:NSMakeRange(0, 13)];
    [attributeStr addAttribute:NSForegroundColorAttributeName
                         value:[UIColor blackColor]
                         range:NSMakeRange(0, 13)];
    // 设置单位字体和颜色
    [attributeStr addAttribute:NSFontAttributeName
                         value:[UIFont systemFontOfSize:13]
                         range:NSMakeRange(13, 9)];
//    [attributeStr addAttribute:NSForegroundColorAttributeName
//                         value:UIColorFromRGB(0x00B6FB)
//                         range:NSMakeRange(13, 9)];
    
    [attributeStr addAttribute:NSFontAttributeName
                         value:[UIFont systemFontOfSize:13]
                         range:NSMakeRange(22, 73)];
    [attributeStr addAttribute:NSForegroundColorAttributeName
                         value:[UIColor blackColor]
                         range:NSMakeRange(22, 73)];
    
    footview.comeinLabel.attributedText = attributeStr;
    
    [footview.ComeinNegotiate addTarget:self action:@selector(seeTheApplicationForm) forControlEvents:UIControlEventTouchUpInside];
    [footview.commitBtn addTarget:self action:@selector(CommitRiskScore) forControlEvents:UIControlEventTouchUpInside];
    self.footview = footview;
    self.tableView.tableFooterView = self.footview;
}

#pragma mark - 获取商品数据
- (void)loadData:(BOOL)isRefresh changeType:(BOOL)isChange selectedIndex:(long)selectedIndex
{
#pragma mark - Table view data source
    if (!_dataArray) {
        _dataArray = [NSArray new];
        // 解析本地JSON文件获取数据，生产环境中从网络获取JSON
        NSString *path = [[NSBundle mainBundle] pathForResource:@"risk" ofType:@"json"];
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];

        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        _dataArray = [JSRiskEvaluateModel objectArrayWithKeyValuesArray:dict[@"question"]];
        
        NSLog(@"_dataArray.count = %ld", _dataArray.count);
    }
    
}

- (void)setCommitBtnAndAttendBtn
{
    self.commitBtn = [[UIButton alloc] init];
    self.commitBtn.x = 20;
    self.commitBtn.y = self.tableView.frame.size.height - 100;
    self.commitBtn.width = kScreenW - 40;
    self.commitBtn.height = 40;
    [self.commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.commitBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.commitBtn setBackgroundColor:[UIColor redColor]];
    [self.commitBtn addTarget:self action:@selector(CommitRiskScore) forControlEvents:UIControlEventTouchUpInside];
    
    [self.commitBtn.layer setCornerRadius:5.0];
    
    self.attentMeeting = [[UIButton alloc] init];
    self.attentMeeting.x = 60;
    self.attentMeeting.y = self.tableView.frame.size.height - 140;
    self.attentMeeting.width = kScreenW - 120;
    self.attentMeeting.height = 20;
    [self.attentMeeting.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self.attentMeeting setAdjustsImageWhenHighlighted:NO];
    [self.attentMeeting.titleLabel setFont:[UIFont systemFontOfSize:13]];
    NSAttributedString *attributedText = [self attributedString1:@"我同意《投资人入会申请》" lastTextIndex:9];
    [self.attentMeeting setTitleColor:[UIColor lightGrayColor]
                             forState:UIControlStateNormal];
    [self.attentMeeting setAttributedTitle:attributedText forState:UIControlStateNormal];
    
    [self.attentMeeting setImage:[UIImage imageNamed:@"icon_a"] forState:UIControlStateNormal];
    [self.attentMeeting addTarget:self action:@selector(seeTheApplicationForm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.commitBtn];
    [self.tableView addSubview:self.attentMeeting];
    
}


- (void)CommitRiskScore
{
    
    if (self.footview.comeInSelectBtn.selected == YES)
    {
        if ((_score1Bool == YES) && (_score2Bool == YES) && (_score3Bool == YES) && (_score4Bool == YES) && (_score5Bool == YES) && (_score6Bool == YES) && (_score7Bool == YES) && (_score8Bool == YES) && (_score9Bool == YES) && (_score10Bool == YES) )
        {
            
            self.riskScore = _score1 + _score2 + _score3 + _score4 + _score5 + _score6 + _score7 + _score8 + _score9 + _score10;
            
            NSLog(@"self.riskScore = %d",self.riskScore);
            CCJWeakSelf;
//            // 在发请求前一定要先停止以前的请求
//            CJNetWorkTools *manager = [CJNetWorkTools shareNetworkTools];
//            [manager.tasks makeObjectsPerformSelector:@selector(cancel)];
//            manager.requestSerializer = [AFJSONRequestSerializer serializer];
//            [manager.requestSerializer setValue:@"Content-type" forHTTPHeaderField:@"application/json;charset=UTF-8"];
//            
//            NSString *sessionId = [NSString stringWithFormat:@"%@",[MPNetworkService sharedService].sessionID];
//            NSString *deviceId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
//            NSString *versonCode = [NSString
//                                    stringWithFormat:@"%@",
//                                    [[NSBundle mainBundle]
//                                     objectForInfoDictionaryKey:(NSString *)
//                                     kCFBundleVersionKey]];
//            // 2.利用AFN发送请求
//            NSDictionary *dict = @{
//                                   @"messageId":@"saveEvaluationData",
//                                   @"sessionId":sessionId,
//                                   @"deviceId":deviceId,
//                                   @"versionCode":versonCode,
//                                   @"riskScore":@(self.riskScore),
//                                   };
//            [manager POST:@"saveEvaluationData" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
//                NSNumber *statusCode = responseObject[@"statusCode"];
//                NSLog(@"statusCode1111 = %@", statusCode);
//                if ([statusCode  isEqual: @0])
//                {
//                    
//                    
////                    if ([self.riskScore isEqualToString:@"null"] || (self.riskScore.length == 0))
////                    {
////                        self.riskLevel.text = @"您目前的风险评级为:暂无评级";
////                    }else
//                    NSString *str;
//                    if (self.riskScore < 20)
//                    {
////                        self.riskLevel.text = @"您目前的风险评级为: 保守型";
//                        str = [NSString stringWithFormat:@"您好, 您的测试结果为:20分以下,属于保守型的投资人, 可以考虑货币型等低风险产品"];
//                        [self addRiskEvaluateViewWithTitle1:str];
//                    }else if (self.riskScore >= 20 && self.riskScore <= 39)
//                    {
////                        self.riskLevel.text = @"您目前的风险评级为: 稳健型";
//                        str = [NSString stringWithFormat:@"您好, 您的测试结果为:20分-39分,属于稳健型的投资人, 我们建议您考虑的投资产品应该可让资本金不被通货膨胀侵蚀,产品预期收益率较高但价格波动性也高于保守型的投资人, 您可以考虑风险较低的债券型产品, 并少量介入风险承担较高的产品"];
//                        [self addRiskEvaluateViewWithTitle2:str];
//                    }else if (self.riskScore > 39)
//                    {
////                     self.riskLevel.text = @"您目前的风险评级为: 积极型";
//                        str = [NSString stringWithFormat:@"您好, 您的测试结果为:大于39分,属于积极型的投资人, 我们建议您考虑投资品的投资收益率远高于通货膨胀率, 您既可以考虑低分险产品,也可以考虑部分持有风险程度较高的产品"];
//                        [self addRiskEvaluateViewWithTitle3:str];
//                    }
//
//                    
//                    
//                    // 在设置中也保存评级分数, 确保投资的时候分数准确
//                    [MPNetworkService sharedService].riskScore = [NSString stringWithFormat:@"%d", self.riskScore];
//
//                    NSLog(@"saveEvaluationData~~~ ");
//                    
//                    //            [SVProgressHUD showSuccessWithStatus:@"数据提交成功!"];
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        //                [SVProgressHUD dismiss];
//                        //                [self noRiskEvaluate];
//                        //                [self.navigationController popViewControllerAnimated:YES];
//                    });
//                    
//                }else
//                {
//                    [SVProgressHUD showErrorWithStatus:@"请求异常,请稍后重试"];
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        [SVProgressHUD dismiss];
//                    });
//                }
//                
//                [weakSelf.tableView reloadData];
//                
//            } failure:^(NSURLSessionDataTask *task, NSError *error) {
//                
//                [SVProgressHUD showErrorWithStatus:@"网络错误请稍后重试"];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [SVProgressHUD dismiss];
//                    
//                });
//                NSLog(@"error = %@", error);
//            }];
            
        }else
        {
            [self addRiskEvaluateViewWithTitle:@"请选择全部问题!"];
            return;
        }
        
  }else
    {
      
        
//        [SVProgressHUD showInfoWithStatus:@"请同意《投资人入会申请》"];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [SVProgressHUD dismiss];
//            
//        });

    }
    
}

// 点击投资人入会申请
//- (void)seeTheApplicationForm
//{
//    CJWebworkTools *webwork = [[CJWebworkTools alloc] init];
//    
//    NSString *webstr = [webwork webString];
//    NSString *urlNewinfo = [NSString stringWithFormat:@"%@riskAgreement",webstr];
//    NSURL *url  = [NSURL URLWithString:urlNewinfo];
//    JSFindWebViewController *findWebview = [[JSFindWebViewController alloc] init];
//    findWebview.webViewUrl = url;
//    findWebview.titleString = @"question";
//    //    findWebview.titleLab = cell.fridens.title;
//    [self.navigationController pushViewController:findWebview animated:YES];
//}


- (void)addRiskEvaluateViewWithTitle:(NSString *)title
{
    JSRiskEvaluateAlertView *view = [JSRiskEvaluateAlertView viewFromXib];
    view.alertValue = [NSMutableString stringWithFormat:@"%d",2];

    view.width = kScreenW;
    view.height = kScreenH;
    view.centerX = kScreenW * 0.5;
    view.centerY = kScreenH * 0.5;

    view.titleLabel.text = title;
    
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [view.gotoEvaluateBtn setTitle:@"确定" forState:UIControlStateNormal];
    [view.gotoEvaluateBtn addTarget:self action:@selector(gotoRiskEvaluate) forControlEvents:UIControlEventTouchUpInside];
    view.noRiskBtn.hidden = YES;
    [view.noRiskBtn addTarget:self action:@selector(noRiskEvaluate) forControlEvents:UIControlEventTouchUpInside];
    self.RiskAlertView = view.RiskAlertView;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    
    tap.delegate = self;
    self.nView = view;
    [self.nView addGestureRecognizer:tap];
    
    [[[UIApplication  sharedApplication] keyWindow] addSubview : self.nView];
}

- (void)addRiskEvaluateViewWithTitle1:(NSString *)title
{
    JSRiskEvaluateAlertView *view = [JSRiskEvaluateAlertView viewFromXib];
    view.alertValue = [NSMutableString stringWithFormat:@"%d",5];
    
    view.width = kScreenW;
    view.height = kScreenH;
    view.centerX = kScreenW * 0.5;
    view.centerY = kScreenH * 0.5;
    
    view.titleLabel.text = title;
    
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [view.gotoEvaluateBtn setTitle:@"确定" forState:UIControlStateNormal];
    [view.gotoEvaluateBtn addTarget:self action:@selector(gotoRiskEvaluate) forControlEvents:UIControlEventTouchUpInside];
    view.noRiskBtn.hidden = YES;
    [view.noRiskBtn addTarget:self action:@selector(noRiskEvaluate) forControlEvents:UIControlEventTouchUpInside];
    self.RiskAlertView = view.RiskAlertView;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    
    tap.delegate = self;
    self.nView = view;
    [self.nView addGestureRecognizer:tap];
    
    [[[UIApplication  sharedApplication] keyWindow] addSubview : self.nView];
}

- (void)addRiskEvaluateViewWithTitle2:(NSString *)title
{
    JSRiskEvaluateAlertView *view = [JSRiskEvaluateAlertView viewFromXib];
    view.alertValue = [NSMutableString stringWithFormat:@"%d",6];
    
    view.width = kScreenW;
    view.height = kScreenH;
    view.centerX = kScreenW * 0.5;
    view.centerY = kScreenH * 0.5;
    
    view.titleLabel.text = title;
    
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [view.gotoEvaluateBtn setTitle:@"确定" forState:UIControlStateNormal];
    [view.gotoEvaluateBtn addTarget:self action:@selector(gotoRiskEvaluate) forControlEvents:UIControlEventTouchUpInside];
    view.noRiskBtn.hidden = YES;
    [view.noRiskBtn addTarget:self action:@selector(noRiskEvaluate) forControlEvents:UIControlEventTouchUpInside];
    self.RiskAlertView = view.RiskAlertView;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    
    tap.delegate = self;
    self.nView = view;
    [self.nView addGestureRecognizer:tap];
    
    [[[UIApplication  sharedApplication] keyWindow] addSubview : self.nView];
}

- (void)addRiskEvaluateViewWithTitle3:(NSString *)title
{
    JSRiskEvaluateAlertView *view = [JSRiskEvaluateAlertView viewFromXib];
    view.alertValue = [NSMutableString stringWithFormat:@"%d",7];
    
    view.width = kScreenW;
    view.height = kScreenH;
    view.centerX = kScreenW * 0.5;
    view.centerY = kScreenH * 0.5;
    
    view.titleLabel.text = title;
    
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [view.gotoEvaluateBtn setTitle:@"确定" forState:UIControlStateNormal];
    [view.gotoEvaluateBtn addTarget:self action:@selector(gotoRiskEvaluate) forControlEvents:UIControlEventTouchUpInside];
    view.noRiskBtn.hidden = YES;
    [view.noRiskBtn addTarget:self action:@selector(noRiskEvaluate) forControlEvents:UIControlEventTouchUpInside];
    self.RiskAlertView = view.RiskAlertView;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    
    tap.delegate = self;
    self.nView = view;
    [self.nView addGestureRecognizer:tap];
    
    [[[UIApplication  sharedApplication] keyWindow] addSubview : self.nView];
}


- (void)gotoRiskEvaluate
{
    if ((_score1Bool == YES) && (_score2Bool == YES) && (_score3Bool == YES) && (_score4Bool == YES) && (_score5Bool == YES) && (_score6Bool == YES) && (_score7Bool == YES) && (_score8Bool == YES) && (_score9Bool == YES) && (_score10Bool == YES) ) {
        [self.navigationController popViewControllerAnimated:YES];
        [self noRiskEvaluate];
       
    }else
    {
        [self noRiskEvaluate];
        
        // 滚到相应位置
        [self scrolltoRow];
    }
}

- (void)scrolltoRow
{
    for (int i = 0; i < 10; i++)
    {
        if (![self.cellMarkArray[i] isKindOfClass:[NSMutableDictionary class]])
        {
            
            [self.tableView reloadData];
            [self.tableView layoutIfNeeded];
            //刷新完成
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]  atScrollPosition:UITableViewScrollPositionTop animated:YES];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //刷新完成
//                //刷新完成
//                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]  atScrollPosition:UITableViewScrollPositionTop animated:YES];
//            });
//            

            return;
        }
    }
   
}

- (void)noRiskEvaluate
{
    [self.nView removeFromSuperview];
}

// 当触发点按手势的时候调用
- (void)tap:(UITapGestureRecognizer *)sendr
{
    if (CGRectContainsPoint(self.RiskAlertView.frame, [sendr locationInView:self.nView]))
    {
        
    }else
    {
        [self.nView removeFromSuperview];
    }
}

- (NSMutableArray *)questionLabelArr
{
    if (!_questionLabelArr)
    {
        _questionLabelArr = [NSMutableArray array];
    }
    return _questionLabelArr;
}

- (NSMutableArray *)cellMarkArray
{
    if (!_cellMarkArray)
    {
        _cellMarkArray = [NSMutableArray arrayWithObjects:kObjcNull, kObjcNull, kObjcNull, kObjcNull, kObjcNull, kObjcNull, kObjcNull, kObjcNull, kObjcNull, kObjcNull,nil];
//        _cellMarkArray = [NSMutableArray array];
    }
    return _cellMarkArray;
}

//- (NSMutableDictionary *)cellMarkDic
//{
//    if (!_cellMarkDic)
//    {
//        _cellMarkDic = [NSMutableDictionary dictionary];;
//    }
//    return _cellMarkDic;
//}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 8)
    {
        return 6;
    }else
    {
        return 5;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    JSQuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:question forIndexPath:indexPath];
    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
//    JSQuestionTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    if (cell == nil) {
//        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSQuestionTableViewCell class]) owner:nil options:nil] lastObject];
//    }

    
//    cell.riskModel = _dataArray[indexPath.row];
//    cell.index = (int)indexPath.row ;
    
    
    
//    if ([self.cellMarkArray[indexPath.section] isKindOfClass:[NSMutableDictionary class]])
//    {
//         NSMutableDictionary *dic = self.cellMarkArray[indexPath.section];
//    }
    
//    if (_cellMarkArray.count != 0)
//    {
////        for (int i = 0; i < self.cellMarkArray.count; i++)
////        {
////            
////        }
//        
//        for (NSDictionary *dic in self.cellMarkArray) {
//            if ([[dic objectForKey:@"0"] isEqualToString:@"1"])
//        }
//    }
    
    

     NSLog(@"indexPath.section = %ld", indexPath.section);
    id dic = self.cellMarkArray[indexPath.section];
    NSLog(@"dic  = %@", dic);
    
    // 思路 , 先取出字典保存的选中的标识, 根据标识队形生成按钮的状态
    
    JSRiskEvaluateModel *riskModel = _dataArray[indexPath.section];
    
   
    if (indexPath.section == 0)
    {
//        if (self.cellMarkArray.count != 0)
//        {
        
        // 如果是字典类, 说明这个组的在数组中的位置为字典, 说明之前有点击过这个组的按钮
        if ([self.cellMarkArray[indexPath.section] isKindOfClass:[NSMutableDictionary class]] )
        {
            UITableViewCell * cell;
            NSMutableDictionary *dic = self.cellMarkArray[indexPath.section];

            if ([[dic objectForKey:@"0"] isEqualToString:@"1"])
            {
                cell = [self SelectCellOneView:indexPath andTableView:tableView andRiskModel:riskModel];
                
            }else if ([[dic objectForKey:@"0"] isEqualToString:@"2"])
            {
                cell = [self SelectCellTwoView:indexPath andTableView:tableView andRiskModel:riskModel];
                
            }else if ([[dic objectForKey:@"0"] isEqualToString:@"3"])
            {
                cell = [self SelectCellThreeView:indexPath andTableView:tableView andRiskModel:riskModel];
            }else if ([[dic objectForKey:@"0"] isEqualToString:@"4"])
            {
                cell = [self SelectCellForeView:indexPath andTableView:tableView andRiskModel:riskModel];
                
            }else
            {
                // 普通没有被选中状态
                cell = [self nomallCellView:indexPath andTableView:tableView andRiskModel:riskModel];
            }
            
            return cell;

        }else
        {
            // 没有点击过, 就返回没选中的cell
            // 普通没有被选中状态
             UITableViewCell * cell = [self nomallCellView:indexPath andTableView:tableView andRiskModel:riskModel];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
    }else if (indexPath.section == 1)
    {
        if ([self.cellMarkArray[indexPath.section] isKindOfClass:[NSMutableDictionary class]] )
        {

            UITableViewCell * cell;
            NSMutableDictionary *dic = self.cellMarkArray[indexPath.section];
            if ([[dic objectForKey:@"1"] isEqualToString:@"1"])
            {
                cell = [self SelectCellOneView:indexPath andTableView:tableView andRiskModel:riskModel];
            }else if ([[dic objectForKey:@"1"] isEqualToString:@"2"])
            {
                cell = [self SelectCellTwoView:indexPath andTableView:tableView andRiskModel:riskModel];
                
            }else if ([[dic objectForKey:@"1"] isEqualToString:@"3"])
            {
                cell = [self SelectCellThreeView:indexPath andTableView:tableView andRiskModel:riskModel];
            }else if ([[dic objectForKey:@"1"] isEqualToString:@"4"])
            {
                cell = [self SelectCellForeView:indexPath andTableView:tableView andRiskModel:riskModel];
                
            }else
            {
                // 普通没有被选中状态
                cell = [self nomallCellView:indexPath andTableView:tableView andRiskModel:riskModel];
            }

                
            return cell;
            
        }else
        {
            // 没有点击过, 就返回没选中的cell
            // 普通没有被选中状态
            UITableViewCell * cell = [self nomallCellView:indexPath andTableView:tableView andRiskModel:riskModel];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }

    }else if (indexPath.section == 2)
    {
        if ([self.cellMarkArray[indexPath.section] isKindOfClass:[NSMutableDictionary class]] )
        {
            UITableViewCell * cell;
            NSMutableDictionary *dic = self.cellMarkArray[indexPath.section];
            if ([[dic objectForKey:@"2"] isEqualToString:@"1"])
            {
                cell = [self SelectCellOneView:indexPath andTableView:tableView andRiskModel:riskModel];
            }else if ([[dic objectForKey:@"2"] isEqualToString:@"2"])
            {
                cell = [self SelectCellTwoView:indexPath andTableView:tableView andRiskModel:riskModel];
                
            }else if ([[dic objectForKey:@"2"] isEqualToString:@"3"])
            {
                cell = [self SelectCellThreeView:indexPath andTableView:tableView andRiskModel:riskModel];
            }else if ([[dic objectForKey:@"2"] isEqualToString:@"4"])
            {
                cell = [self SelectCellForeView:indexPath andTableView:tableView andRiskModel:riskModel];
                
            }else
            {
                // 普通没有被选中状态
                cell = [self nomallCellView:indexPath andTableView:tableView andRiskModel:riskModel];
            }

            return cell;
        }else
        {
            // 没有点击过, 就返回没选中的cell
            // 普通没有被选中状态
            UITableViewCell * cell = [self nomallCellView:indexPath andTableView:tableView andRiskModel:riskModel];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }

    }else if (indexPath.section == 3)
    {
        if ([self.cellMarkArray[indexPath.section] isKindOfClass:[NSMutableDictionary class]] )
        {
            UITableViewCell * cell;
            NSMutableDictionary *dic = self.cellMarkArray[indexPath.section];
            if ([[dic objectForKey:@"3"] isEqualToString:@"1"])
            {
                cell = [self SelectCellOneView:indexPath andTableView:tableView andRiskModel:riskModel];
            }else if ([[dic objectForKey:@"3"] isEqualToString:@"2"])
            {
                cell = [self SelectCellTwoView:indexPath andTableView:tableView andRiskModel:riskModel];
                
            }else if ([[dic objectForKey:@"3"] isEqualToString:@"3"])
            {
                cell = [self SelectCellThreeView:indexPath andTableView:tableView andRiskModel:riskModel];
            }else if ([[dic objectForKey:@"3"] isEqualToString:@"4"])
            {
                cell = [self SelectCellForeView:indexPath andTableView:tableView andRiskModel:riskModel];
                
            }else
            {
                // 普通没有被选中状态
                cell = [self nomallCellView:indexPath andTableView:tableView andRiskModel:riskModel];
            }

            return cell;
        }else
        {
            // 没有点击过, 就返回没选中的cell
            // 普通没有被选中状态
            UITableViewCell * cell = [self nomallCellView:indexPath andTableView:tableView andRiskModel:riskModel];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }

    }else if (indexPath.section == 4)
    {
        if ([self.cellMarkArray[indexPath.section] isKindOfClass:[NSMutableDictionary class]] )
        {
            UITableViewCell * cell;
            NSMutableDictionary *dic = self.cellMarkArray[indexPath.section];
            if ([[dic objectForKey:@"4"] isEqualToString:@"1"])
            {
                cell = [self SelectCellOneView:indexPath andTableView:tableView andRiskModel:riskModel];
            }else if ([[dic objectForKey:@"4"] isEqualToString:@"2"])
            {
                cell = [self SelectCellTwoView:indexPath andTableView:tableView andRiskModel:riskModel];
                
            }else if ([[dic objectForKey:@"4"] isEqualToString:@"3"])
            {
                cell = [self SelectCellThreeView:indexPath andTableView:tableView andRiskModel:riskModel];
            }else if ([[dic objectForKey:@"4"] isEqualToString:@"4"])
            {
                cell = [self SelectCellForeView:indexPath andTableView:tableView andRiskModel:riskModel];
                
            }else
            {
                // 普通没有被选中状态
                cell = [self nomallCellView:indexPath andTableView:tableView andRiskModel:riskModel];
            }

            return cell;
        }else
        {
            // 没有点击过, 就返回没选中的cell
            // 普通没有被选中状态
            UITableViewCell * cell = [self nomallCellView:indexPath andTableView:tableView andRiskModel:riskModel];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }

    }else if (indexPath.section == 5)
    {
        if ([self.cellMarkArray[indexPath.section] isKindOfClass:[NSMutableDictionary class]] )
        {
            UITableViewCell * cell;
            NSMutableDictionary *dic = self.cellMarkArray[indexPath.section];
            if ([[dic objectForKey:@"5"] isEqualToString:@"1"])
            {
                cell = [self SelectCellOneView:indexPath andTableView:tableView andRiskModel:riskModel];
            }else if ([[dic objectForKey:@"5"] isEqualToString:@"2"])
            {
                cell = [self SelectCellTwoView:indexPath andTableView:tableView andRiskModel:riskModel];
                
            }else if ([[dic objectForKey:@"5"] isEqualToString:@"3"])
            {
                cell = [self SelectCellThreeView:indexPath andTableView:tableView andRiskModel:riskModel];
            }else if ([[dic objectForKey:@"5"] isEqualToString:@"4"])
            {
                cell = [self SelectCellForeView:indexPath andTableView:tableView andRiskModel:riskModel];
                
            }else
            {
                // 普通没有被选中状态
                cell = [self nomallCellView:indexPath andTableView:tableView andRiskModel:riskModel];
            }

            return cell;
        }else
        {
            // 没有点击过, 就返回没选中的cell
            // 普通没有被选中状态
            UITableViewCell * cell = [self nomallCellView:indexPath andTableView:tableView andRiskModel:riskModel];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }

    }else if (indexPath.section == 6)
    {
        if ([self.cellMarkArray[indexPath.section] isKindOfClass:[NSMutableDictionary class]] )
        {
            UITableViewCell * cell;
            NSMutableDictionary *dic = self.cellMarkArray[indexPath.section];
            if ([[dic objectForKey:@"6"] isEqualToString:@"1"])
            {
                cell = [self SelectCellOneView:indexPath andTableView:tableView andRiskModel:riskModel];
            }else if ([[dic objectForKey:@"6"] isEqualToString:@"2"])
            {
                cell = [self SelectCellTwoView:indexPath andTableView:tableView andRiskModel:riskModel];
                
            }else if ([[dic objectForKey:@"6"] isEqualToString:@"3"])
            {
                cell = [self SelectCellThreeView:indexPath andTableView:tableView andRiskModel:riskModel];
            }else if ([[dic objectForKey:@"6"] isEqualToString:@"4"])
            {
                cell = [self SelectCellForeView:indexPath andTableView:tableView andRiskModel:riskModel];
                
            }else
            {
                // 普通没有被选中状态
                cell = [self nomallCellView:indexPath andTableView:tableView andRiskModel:riskModel];
            }

            return cell;
        }else
        {
            // 没有点击过, 就返回没选中的cell
            // 普通没有被选中状态
            UITableViewCell * cell = [self nomallCellView:indexPath andTableView:tableView andRiskModel:riskModel];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }

    }else if (indexPath.section == 7)
    {
        if ([self.cellMarkArray[indexPath.section] isKindOfClass:[NSMutableDictionary class]] )
        {
            UITableViewCell * cell;
            NSMutableDictionary *dic = self.cellMarkArray[indexPath.section];
            if ([[dic objectForKey:@"7"] isEqualToString:@"1"])
            {
                cell = [self SelectCellOneView:indexPath andTableView:tableView andRiskModel:riskModel];
            }else if ([[dic objectForKey:@"7"] isEqualToString:@"2"])
            {
                cell = [self SelectCellTwoView:indexPath andTableView:tableView andRiskModel:riskModel];
                
            }else if ([[dic objectForKey:@"7"] isEqualToString:@"3"])
            {
                cell = [self SelectCellThreeView:indexPath andTableView:tableView andRiskModel:riskModel];
            }else if ([[dic objectForKey:@"7"] isEqualToString:@"4"])
            {
                cell = [self SelectCellForeView:indexPath andTableView:tableView andRiskModel:riskModel];
                
            }else
            {
                // 普通没有被选中状态
                cell = [self nomallCellView:indexPath andTableView:tableView andRiskModel:riskModel];
            }
            return cell;
        }else
        {
            // 没有点击过, 就返回没选中的cell
            // 普通没有被选中状态
            UITableViewCell * cell = [self nomallCellView:indexPath andTableView:tableView andRiskModel:riskModel];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }


    }else if (indexPath.section == 8)
    {
        if ([self.cellMarkArray[indexPath.section] isKindOfClass:[NSMutableDictionary class]] )
        {
            UITableViewCell * cell;
            NSMutableDictionary *dic = self.cellMarkArray[indexPath.section];
            if ([[dic objectForKey:@"8"] isEqualToString:@"1"])
            {
                cell = [self SelectCellOneView:indexPath andTableView:tableView andRiskModel:riskModel];
            }else if ([[dic objectForKey:@"8"] isEqualToString:@"2"])
            {
                cell = [self SelectCellTwoView:indexPath andTableView:tableView andRiskModel:riskModel];
                
            }else if ([[dic objectForKey:@"8"] isEqualToString:@"3"])
            {
                cell = [self SelectCellThreeView:indexPath andTableView:tableView andRiskModel:riskModel];
            }else if ([[dic objectForKey:@"8"] isEqualToString:@"4"])
            {
                cell = [self SelectCellForeView:indexPath andTableView:tableView andRiskModel:riskModel];
                
            }else if ([[dic objectForKey:@"8"] isEqualToString:@"5"])
            {
                cell = [self SelectCellFiveView:indexPath andTableView:tableView andRiskModel:riskModel];
                
            }else
            {
                // 普通没有被选中状态
                cell = [self nomallCellView:indexPath andTableView:tableView andRiskModel:riskModel];
            }
            return cell;
        }else
        {
            // 没有点击过, 就返回没选中的cell
            // 普通没有被选中状态
            UITableViewCell * cell = [self nomallCellView:indexPath andTableView:tableView andRiskModel:riskModel];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }


    }else if (indexPath.section == 9)
    {
        if ([self.cellMarkArray[indexPath.section] isKindOfClass:[NSMutableDictionary class]] )
        {
            UITableViewCell * cell;
            NSMutableDictionary *dic = self.cellMarkArray[indexPath.section];
            if ([[dic objectForKey:@"9"] isEqualToString:@"1"])
            {
                cell = [self SelectCellOneView:indexPath andTableView:tableView andRiskModel:riskModel];
            }else if ([[dic objectForKey:@"9"] isEqualToString:@"2"])
            {
                cell = [self SelectCellTwoView:indexPath andTableView:tableView andRiskModel:riskModel];
                
            }else if ([[dic objectForKey:@"9"] isEqualToString:@"3"])
            {
                cell = [self SelectCellThreeView:indexPath andTableView:tableView andRiskModel:riskModel];
            }else if ([[dic objectForKey:@"9"] isEqualToString:@"4"])
            {
                cell = [self SelectCellForeView:indexPath andTableView:tableView andRiskModel:riskModel];
                
            }else
            {
                // 普通没有被选中状态
                cell = [self nomallCellView:indexPath andTableView:tableView andRiskModel:riskModel];
            }
            return cell;
        }else
        {
            // 没有点击过, 就返回没选中的cell
            // 普通没有被选中状态
            UITableViewCell * cell = [self nomallCellView:indexPath andTableView:tableView andRiskModel:riskModel];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        
    }else
    {
        if ([self.cellMarkArray[indexPath.section] isKindOfClass:[NSMutableDictionary class]] )
        {
            UITableViewCell * cell;
            NSMutableDictionary *dic = self.cellMarkArray[indexPath.section];
            if ([[dic objectForKey:@"9"] isEqualToString:@"1"])
            {
                cell = [self SelectCellOneView:indexPath andTableView:tableView andRiskModel:riskModel];
            }else if ([[dic objectForKey:@"9"] isEqualToString:@"2"])
            {
                cell = [self SelectCellTwoView:indexPath andTableView:tableView andRiskModel:riskModel];
                
            }else if ([[dic objectForKey:@"9"] isEqualToString:@"3"])
            {
                cell = [self SelectCellThreeView:indexPath andTableView:tableView andRiskModel:riskModel];
            }else if ([[dic objectForKey:@"9"] isEqualToString:@"4"])
            {
                cell = [self SelectCellFiveView:indexPath andTableView:tableView andRiskModel:riskModel];
                
            }else
            {
                // 普通没有被选中状态
                cell = [self nomallCellView:indexPath andTableView:tableView andRiskModel:riskModel];
            }
            
            return cell;
        }else
        {
            // 没有点击过, 就返回没选中的cell
            // 普通没有被选中状态
            UITableViewCell * cell = [self nomallCellView:indexPath andTableView:tableView andRiskModel:riskModel];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }

    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        JSRiskEvaluateModel *riskModel = _dataArray[indexPath.section];
        return riskModel.cellHeight1;

    }
    return 50;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        
        JSRiskEvaluateModel *riskModel = _dataArray[indexPath.section];
        NSMutableDictionary *cellMarkDic = [NSMutableDictionary dictionary];

        if (indexPath.row == 0)
        {
            
        }else
        {
        // 取消前一个选中的，就是单选啦
        NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:_index0 inSection:0];
        // 前一个选中的为第一个
        if (lastIndex.row == 1)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];

        }else if (lastIndex.row == 2)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
        }else if (lastIndex.row == 3)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
        }else if (lastIndex.row == 4)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
        }

        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell.questionBtn setSelected:YES];
        
        // 保存选中的
        _index0 = indexPath.row;
        
        [self.tableView performSelector:@selector(deselectRowAtIndexPath:animated:) withObject:indexPath afterDelay:.5];
      
        NSLog(@"_index = %ld", _index0);

        }
        if (indexPath.row == 0)
        {
            
        }else if (indexPath.row == 1)
        {
            self.score1 = riskModel.scoreA;
            self.score1Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            
            cell.line.hidden = YES;
            [cellMarkDic setObject:@"1" forKey:@"0"];

            
        }else if (indexPath.row == 2)
        {
            self.score1 = riskModel.scoreB;
            self.score1Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            cell.line.hidden = YES;
            [cellMarkDic setObject:@"2" forKey:@"0"];
            
        }else if (indexPath.row == 3)
        {
            self.score1 = riskModel.scoreC;
            self.score1Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            cell.line.hidden = YES;
            [cellMarkDic setObject:@"3" forKey:@"0"];
            
        }else if (indexPath.row == 4)
        {
            self.score1 = riskModel.scoreD;
            self.score1Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            cell.line.hidden = NO;
            [cellMarkDic setObject:@"4" forKey:@"0"];
            
        }
        
//        [self.cellMarkArray insertObject:cellMarkDic atIndex:0];
        [self.cellMarkArray replaceObjectAtIndex:0 withObject:cellMarkDic];
    }else if (indexPath.section == 1)
    {
        JSRiskEvaluateModel *riskModel = _dataArray[indexPath.section];
        NSMutableDictionary *cellMarkDic = [NSMutableDictionary dictionary];
        
        if (indexPath.row == 0)
        {
            
        }else
        {
        // 取消前一个选中的，就是单选啦
        NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:_index1 inSection:1];
        // 前一个选中的为第一个
        if (lastIndex.row == 1)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
            
        }else if (lastIndex.row == 2)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
        }else if (lastIndex.row == 3)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
        }else if (lastIndex.row == 4)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
        }
        
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell.questionBtn setSelected:YES];
        
        // 保存选中的
        _index1 = indexPath.row;
        
        [self.tableView performSelector:@selector(deselectRowAtIndexPath:animated:) withObject:indexPath afterDelay:.5];
        
        NSLog(@"_index = %ld", _index1);
        }
        
        if (indexPath.row == 0)
        {
            
        }else if (indexPath.row == 1)
        {
            self.score2 = riskModel.scoreA;
            self.score2Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            cell.line.hidden = YES;
            
            [cellMarkDic setObject:@"1" forKey:@"1"];
            
            
        }else if (indexPath.row == 2)
        {
            self.score2 = riskModel.scoreB;
            self.score2Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            cell.line.hidden = YES;
            [cellMarkDic setObject:@"2" forKey:@"1"];
            
        }else if (indexPath.row == 3)
        {
            self.score2 = riskModel.scoreC;
            self.score2Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            cell.line.hidden = YES;
            [cellMarkDic setObject:@"3" forKey:@"1"];
            
        }else if (indexPath.row == 4)
        {
            self.score2 = riskModel.scoreD;
            self.score2Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            cell.line.hidden = NO;
            [cellMarkDic setObject:@"4" forKey:@"1"];
            
        }
        
//        [self.cellMarkArray insertObject:cellMarkDic atIndex:1];
        [self.cellMarkArray replaceObjectAtIndex:1 withObject:cellMarkDic];
    }else if (indexPath.section == 2)
    {
        JSRiskEvaluateModel *riskModel = _dataArray[indexPath.section];
        NSMutableDictionary *cellMarkDic = [NSMutableDictionary dictionary];
        if (indexPath.row == 0)
        {
            
        }else
        {
        // 取消前一个选中的，就是单选啦
        NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:_index2 inSection:2];
        // 前一个选中的为第一个
        if (lastIndex.row == 1)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
            
        }else if (lastIndex.row == 2)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
        }else if (lastIndex.row == 3)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
        }else if (lastIndex.row == 4)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
        }
        
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell.questionBtn setSelected:YES];
        
        // 保存选中的
        _index2 = indexPath.row;
        
        [self.tableView performSelector:@selector(deselectRowAtIndexPath:animated:) withObject:indexPath afterDelay:.5];
        
        NSLog(@"_index = %ld", _index2);
        }
        
        if (indexPath.row == 0)
        {
            
        }else if (indexPath.row == 1)
        {
            self.score3 = riskModel.scoreA;
            self.score3Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            
            cell.line.hidden = YES;
            [cellMarkDic setObject:@"1" forKey:@"2"];
            
            
        }else if (indexPath.row == 2)
        {
            self.score3 = riskModel.scoreB;
            self.score3Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            cell.line.hidden = YES;
            [cellMarkDic setObject:@"2" forKey:@"2"];
            
        }else if (indexPath.row == 3)
        {
            self.score3 = riskModel.scoreC;
            self.score3Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            cell.line.hidden = YES;
            [cellMarkDic setObject:@"3" forKey:@"2"];
            
        }else if (indexPath.row == 4)
        {
            self.score3 = riskModel.scoreD;
            self.score3Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            cell.line.hidden = NO;
            [cellMarkDic setObject:@"4" forKey:@"2"];
            
        }
        
//        [self.cellMarkArray insertObject:cellMarkDic atIndex:2];
        [self.cellMarkArray replaceObjectAtIndex:2 withObject:cellMarkDic];
    }else if (indexPath.section == 3)
    {
        JSRiskEvaluateModel *riskModel = _dataArray[indexPath.section];
        NSMutableDictionary *cellMarkDic = [NSMutableDictionary dictionary];
        if (indexPath.row == 0)
        {
            
        }else
        {
        // 取消前一个选中的，就是单选啦
        NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:_index3 inSection:3];
        // 前一个选中的为第一个
        if (lastIndex.row == 1)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
            
        }else if (lastIndex.row == 2)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
        }else if (lastIndex.row == 3)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
        }else if (lastIndex.row == 4)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
        }
        
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell.questionBtn setSelected:YES];
        
        // 保存选中的
        _index3 = indexPath.row;
        
        [self.tableView performSelector:@selector(deselectRowAtIndexPath:animated:) withObject:indexPath afterDelay:.5];
        
        NSLog(@"_index = %ld", _index3);
        }
        
        if (indexPath.row == 0)
        {
            
        }else if (indexPath.row == 1)
        {
            self.score4 = riskModel.scoreA;
            self.score4Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            cell.line.hidden = YES;
            
            [cellMarkDic setObject:@"1" forKey:@"3"];
            
            
        }else if (indexPath.row == 2)
        {
            self.score4 = riskModel.scoreB;
            self.score4Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            cell.line.hidden = YES;
            [cellMarkDic setObject:@"2" forKey:@"3"];
            
        }else if (indexPath.row == 3)
        {
            self.score4 = riskModel.scoreC;
            self.score4Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            cell.line.hidden = YES;
            [cellMarkDic setObject:@"3" forKey:@"3"];
            
        }else if (indexPath.row == 4)
        {
            self.score4 = riskModel.scoreD;
            self.score4Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            cell.line.hidden = NO;
            [cellMarkDic setObject:@"4" forKey:@"3"];
            
        }
        
//        [self.cellMarkArray insertObject:cellMarkDic atIndex:3];
        [self.cellMarkArray replaceObjectAtIndex:3 withObject:cellMarkDic];
    }else if (indexPath.section == 4)
    {
        JSRiskEvaluateModel *riskModel = _dataArray[indexPath.section];
        NSMutableDictionary *cellMarkDic = [NSMutableDictionary dictionary];

        if (indexPath.row == 0)
        {
            
        }else
        {
            // 取消前一个选中的，就是单选啦
            NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:_index4 inSection:4];
            // 前一个选中的为第一个
            if (lastIndex.row == 1)
            {
                JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
                [lastCell.questionBtn setSelected:NO];
                
            }else if (lastIndex.row == 2)
            {
                JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
                [lastCell.questionBtn setSelected:NO];
            }else if (lastIndex.row == 3)
            {
                JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
                [lastCell.questionBtn setSelected:NO];
            }else if (lastIndex.row == 4)
            {
                JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
                [lastCell.questionBtn setSelected:NO];
            }
            
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            
            // 保存选中的
            _index4 = indexPath.row;
            
            [self.tableView performSelector:@selector(deselectRowAtIndexPath:animated:) withObject:indexPath afterDelay:.5];
            
            NSLog(@"_index = %ld", _index4);
            

        }
        
        if (indexPath.row == 0)
        {
            
        }else if (indexPath.row == 1)
        {
            self.score5 = riskModel.scoreA;
            self.score5Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            
            cell.line.hidden = YES;
            [cellMarkDic setObject:@"1" forKey:@"4"];
            
            
        }else if (indexPath.row == 2)
        {
            self.score5 = riskModel.scoreB;
            self.score5Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            cell.line.hidden = YES;
            [cellMarkDic setObject:@"2" forKey:@"4"];
            
        }else if (indexPath.row == 3)
        {
            self.score5 = riskModel.scoreC;
            self.score5Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            cell.line.hidden = YES;
            [cellMarkDic setObject:@"3" forKey:@"4"];
            
        }else if (indexPath.row == 4)
        {
            self.score5 = riskModel.scoreD;
            self.score5Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            cell.line.hidden = NO;
            [cellMarkDic setObject:@"4" forKey:@"4"];
            
        }
        
//        [self.cellMarkArray insertObject:cellMarkDic atIndex:4];
        [self.cellMarkArray replaceObjectAtIndex:4 withObject:cellMarkDic];
    }else if (indexPath.section == 5)
    {
        
        JSRiskEvaluateModel *riskModel = _dataArray[indexPath.section];
        NSMutableDictionary *cellMarkDic = [NSMutableDictionary dictionary];
        if (indexPath.row == 0)
        {
            
        }else
        {
        // 取消前一个选中的，就是单选啦
        NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:_index5 inSection:5];
        // 前一个选中的为第一个
        if (lastIndex.row == 1)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
            
        }else if (lastIndex.row == 2)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
        }else if (lastIndex.row == 3)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
        }else if (lastIndex.row == 4)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
        }
        
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell.questionBtn setSelected:YES];
        
        // 保存选中的
        _index5 = indexPath.row;
        
        [self.tableView performSelector:@selector(deselectRowAtIndexPath:animated:) withObject:indexPath afterDelay:.5];
        
        NSLog(@"_index = %ld", _index5);
        
        }
        if (indexPath.row == 0)
        {
            
        }else if (indexPath.row == 1)
        {
            self.score6 = riskModel.scoreA;
            self.score6Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            
            cell.line.hidden = YES;
            [cellMarkDic setObject:@"1" forKey:@"5"];
            
            
        }else if (indexPath.row == 2)
        {
            self.score6 = riskModel.scoreB;
            self.score6Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            cell.line.hidden = YES;
            [cellMarkDic setObject:@"2" forKey:@"5"];
            
        }else if (indexPath.row == 3)
        {
            self.score6 = riskModel.scoreC;
            self.score6Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            cell.line.hidden = YES;
            [cellMarkDic setObject:@"3" forKey:@"5"];
            
        }else if (indexPath.row == 4)
        {
            self.score6 = riskModel.scoreD;
            self.score6Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            cell.line.hidden = NO;
            [cellMarkDic setObject:@"4" forKey:@"5"];
            
        }
        
//        [self.cellMarkArray insertObject:cellMarkDic atIndex:5];
        [self.cellMarkArray replaceObjectAtIndex:5 withObject:cellMarkDic];
    }else if (indexPath.section == 6)
    {
        JSRiskEvaluateModel *riskModel = _dataArray[indexPath.section];
        NSMutableDictionary *cellMarkDic = [NSMutableDictionary dictionary];
        if (indexPath.row == 0)
        {
            
        }else
        {
        // 取消前一个选中的，就是单选啦
        NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:_index6 inSection:6];
        // 前一个选中的为第一个
        if (lastIndex.row == 1)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
            
        }else if (lastIndex.row == 2)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
        }else if (lastIndex.row == 3)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
        }else if (lastIndex.row == 4)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
        }
        
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell.questionBtn setSelected:YES];
        
        // 保存选中的
        _index6 = indexPath.row;
        
        [self.tableView performSelector:@selector(deselectRowAtIndexPath:animated:) withObject:indexPath afterDelay:.5];
        
        NSLog(@"_index = %ld", _index6);
        }
        
        if (indexPath.row == 0)
        {
            
        }else if (indexPath.row == 1)
        {
            self.score7 = riskModel.scoreA;
            self.score7Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            
            cell.line.hidden = YES;
            [cellMarkDic setObject:@"1" forKey:@"6"];
            
            
        }else if (indexPath.row == 2)
        {
            self.score7 = riskModel.scoreB;
            self.score7Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            cell.line.hidden = YES;
            [cellMarkDic setObject:@"2" forKey:@"6"];
            
        }else if (indexPath.row == 3)
        {
            self.score7 = riskModel.scoreC;
            self.score7Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            cell.line.hidden = YES;
            [cellMarkDic setObject:@"3" forKey:@"6"];
            
        }else if (indexPath.row == 4)
        {
            self.score7 = riskModel.scoreD;
            self.score7Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            cell.line.hidden = NO;
            [cellMarkDic setObject:@"4" forKey:@"6"];
            
        }
        
//        [self.cellMarkArray insertObject:cellMarkDic atIndex:6];
        [self.cellMarkArray replaceObjectAtIndex:6 withObject:cellMarkDic];
    }else if (indexPath.section == 7)
    {
        JSRiskEvaluateModel *riskModel = _dataArray[indexPath.section];
        NSMutableDictionary *cellMarkDic = [NSMutableDictionary dictionary];
        if (indexPath.row == 0)
        {
            
        }else
        {
        // 取消前一个选中的，就是单选啦
        NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:_index7 inSection:7];
        // 前一个选中的为第一个
        if (lastIndex.row == 1)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
            
        }else if (lastIndex.row == 2)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
        }else if (lastIndex.row == 3)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
        }else if (lastIndex.row == 4)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
        }
        
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell.questionBtn setSelected:YES];
        
        // 保存选中的
        _index7 = indexPath.row;
        
        [self.tableView performSelector:@selector(deselectRowAtIndexPath:animated:) withObject:indexPath afterDelay:.5];
        
        NSLog(@"_index = %ld", _index7);
        
        }
        if (indexPath.row == 0)
        {
            
        }else if (indexPath.row == 1)
        {
            self.score8 = riskModel.scoreA;
            self.score8Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            
            cell.line.hidden = YES;
            [cellMarkDic setObject:@"1" forKey:@"7"];
            
            
        }else if (indexPath.row == 2)
        {
            self.score8 = riskModel.scoreB;
            self.score8Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            cell.line.hidden = YES;
            [cellMarkDic setObject:@"2" forKey:@"7"];
            
        }else if (indexPath.row == 3)
        {
            self.score8 = riskModel.scoreC;
            self.score8Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.line .hidden = YES;
            [cell.questionBtn setSelected:YES];
            cell.line.hidden = YES;
            [cellMarkDic setObject:@"3" forKey:@"7"];
            
        }else if (indexPath.row == 4)
        {
            self.score8 = riskModel.scoreD;
            self.score8Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            cell.line.hidden = NO;
            [cellMarkDic setObject:@"4" forKey:@"7"];
            
        }
        
//        [self.cellMarkArray insertObject:cellMarkDic atIndex:7];
        [self.cellMarkArray replaceObjectAtIndex:7 withObject:cellMarkDic];
    }else if (indexPath.section == 8)
    {
        JSRiskEvaluateModel *riskModel = _dataArray[indexPath.section];
        NSMutableDictionary *cellMarkDic = [NSMutableDictionary dictionary];
        if (indexPath.row == 0)
        {
            
        }else
        {
        // 取消前一个选中的，就是单选啦
        NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:_index8 inSection:8];
        // 前一个选中的为第一个
        if (lastIndex.row == 1)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
            
        }else if (lastIndex.row == 2)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
        }else if (lastIndex.row == 3)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
        }else if (lastIndex.row == 4)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
        }else if (lastIndex.row == 5)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
        }
        
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell.questionBtn setSelected:YES];
        
        // 保存选中的
        _index8 = indexPath.row;
        
        [self.tableView performSelector:@selector(deselectRowAtIndexPath:animated:) withObject:indexPath afterDelay:.5];
        
        NSLog(@"_index = %ld", _index8);
        
        }
        if (indexPath.row == 0)
        {
            
        }else if (indexPath.row == 1)
        {
            self.score9 = riskModel.scoreA;
            self.score9Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            
            cell.line.hidden = YES;
            [cellMarkDic setObject:@"1" forKey:@"8"];
            
            
        }else if (indexPath.row == 2)
        {
            self.score9 = riskModel.scoreB;
            self.score9Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            cell.line.hidden = YES;
            [cellMarkDic setObject:@"2" forKey:@"8"];
            
        }else if (indexPath.row == 3)
        {
            self.score9 = riskModel.scoreC;
            self.score9Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            cell.line.hidden = YES;
            [cellMarkDic setObject:@"3" forKey:@"8"];
            
        }else if (indexPath.row == 4)
        {
            self.score9 = riskModel.scoreD;
            self.score9Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            cell.line.hidden = YES;
            [cellMarkDic setObject:@"4" forKey:@"8"];
            
            
        }else if (indexPath.row == 5)
        {
            self.score9 = riskModel.scoreD;
            self.score9Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            cell.line.hidden = NO;
            [cellMarkDic setObject:@"5" forKey:@"8"];
            
        }

        
//        [self.cellMarkArray insertObject:cellMarkDic atIndex:8];
        [self.cellMarkArray replaceObjectAtIndex:8 withObject:cellMarkDic];
    }else if (indexPath.section == 9)
    {
        JSRiskEvaluateModel *riskModel = _dataArray[indexPath.section];
        NSMutableDictionary *cellMarkDic = [NSMutableDictionary dictionary];
        if (indexPath.row == 0)
        {
            
        }else
        {
        // 取消前一个选中的，就是单选啦
        NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:_index9 inSection:9];
        // 前一个选中的为第一个
        if (lastIndex.row == 1)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
            
        }else if (lastIndex.row == 2)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
        }else if (lastIndex.row == 3)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
        }else if (lastIndex.row == 4)
        {
            JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            [lastCell.questionBtn setSelected:NO];
        }
        
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell.questionBtn setSelected:YES];
        
        // 保存选中的
        _index9 = indexPath.row;
        
        [self.tableView performSelector:@selector(deselectRowAtIndexPath:animated:) withObject:indexPath afterDelay:.5];
        
        NSLog(@"_index = %ld", _index9);
        
        }
        if (indexPath.row == 0)
        {
            
        }else if (indexPath.row == 1)
        {
            self.score10 = riskModel.scoreA;
            self.score10Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            
            cell.line.hidden = YES;
            [cellMarkDic setObject:@"1" forKey:@"9"];
            
            
        }else if (indexPath.row == 2)
        {
            self.score10 = riskModel.scoreB;
            self.score10Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            cell.line.hidden = YES;
            [cellMarkDic setObject:@"2" forKey:@"9"];
            
        }else if (indexPath.row == 3)
        {
            self.score10 = riskModel.scoreC;
            self.score10Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            cell.line.hidden = YES;
            [cellMarkDic setObject:@"3" forKey:@"9"];
            
        }else if (indexPath.row == 4)
        {
            self.score10 = riskModel.scoreD;
            self.score10Bool =  YES;
            JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.questionBtn setSelected:YES];
            cell.line.hidden = NO;
            [cellMarkDic setObject:@"4" forKey:@"9"];
            
        }
        
//        [self.cellMarkArray insertObject:cellMarkDic atIndex:9];
        [self.cellMarkArray replaceObjectAtIndex:9 withObject:cellMarkDic];
    }



    NSLog(@"self.score1 = %d",self.score1);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.commitBtn.frame =CGRectMake(20, (self.tableView.frame.size.height - 100 + 44) + self.tableView.contentOffset.y , self.commitBtn.frame.size.width,self.commitBtn.frame.size.height);
    self.attentMeeting.frame =CGRectMake(20, (self.tableView.frame.size.height - 140 + 44) + self.tableView.contentOffset.y , self.commitBtn.frame.size.width,self.commitBtn.frame.size.height);
}

- (NSMutableAttributedString *)attributedString1:(NSString *)elementString
                                   lastTextIndex:(int)i {
    NSString *str = elementString;
    NSMutableAttributedString *attr =
    [[NSMutableAttributedString alloc] initWithString:str];
    // 设置金额字体和颜色
    [attr addAttribute:NSFontAttributeName
                 value:[UIFont systemFontOfSize:13]
                 range:NSMakeRange(0, str.length - i)];
    [attr addAttribute:NSForegroundColorAttributeName
                 value:[UIColor lightGrayColor]
                 range:NSMakeRange(0, str.length)];
    // 设置单位字体和颜色
    [attr addAttribute:NSFontAttributeName
                 value:[UIFont systemFontOfSize:13]
                 range:NSMakeRange(str.length - i, i)];
    [attr addAttribute:NSForegroundColorAttributeName
                 value:[UIColor blueColor]
                 range:NSMakeRange(str.length - i, i)];
    return attr;
}


- (UITableViewCell *)nomallCellView:(NSIndexPath *)indexPath andTableView:(UITableView *)tableView andRiskModel:(JSRiskEvaluateModel *)riskModel
{
    if (indexPath.row == 0)
    {
        JSGotoRiskQuestionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:questionTitle];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionTitleStr = riskModel.questionTitle;
        return cell;
    }else if (indexPath.row == 1)
    {
//        JSGotoRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:question];
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSGotoRiskCell class]) owner:nil options:nil] lastObject];
        }

        cell.line.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionLabel.text = riskModel.questionA;
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_a_on"] forState:UIControlStateNormal];
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_a"] forState:UIControlStateSelected];
        return cell;
    }else if (indexPath.row == 2)
    {
//        JSGotoRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:question];
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSGotoRiskCell class]) owner:nil options:nil] lastObject];
        }


        cell.line.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionLabel.text = riskModel.questionB;
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_b_on"] forState:UIControlStateNormal];
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_b"] forState:UIControlStateSelected];
        return cell;
    }else if (indexPath.row == 3)
    {
//        JSGotoRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:question];
        
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSGotoRiskCell class]) owner:nil options:nil] lastObject];
        }

        cell.line.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionLabel.text = riskModel.questionC;
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_c_on"] forState:UIControlStateNormal];
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_c"] forState:UIControlStateSelected];
        return cell;
        
    }else if (indexPath.row == 4)
    {
//        JSGotoRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:question];
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
   
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSGotoRiskCell class]) owner:nil options:nil] lastObject];
        }


        if (indexPath.section == 8)
        {
            cell.line.hidden = YES;
        }else
        {
            cell.line.hidden = NO;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionLabel.text = riskModel.questionD;
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_d_on"] forState:UIControlStateNormal];
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_d"] forState:UIControlStateSelected];
        return cell;
    }else
    {
//        JSGotoRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:question];
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSGotoRiskCell class]) owner:nil options:nil] lastObject];
        }

        if (indexPath.section == 8)
        {
            cell.line.hidden = NO;
        }else
        {
            cell.line.hidden = YES;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionLabel.text = riskModel.questionE;
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_e_on"] forState:UIControlStateNormal];
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_e"] forState:UIControlStateSelected];
        return cell;
    }
    

}

- (UITableViewCell *)SelectCellOneView:(NSIndexPath *)indexPath andTableView:(UITableView *)tableView andRiskModel:(JSRiskEvaluateModel *)riskModel
{
    if (indexPath.row == 0)
    {
        JSGotoRiskQuestionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:questionTitle];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionTitleStr = riskModel.questionTitle;
        return cell;
    }else if (indexPath.row == 1)
    {
        
//        JSGotoRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:question];
        
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSGotoRiskCell class]) owner:nil options:nil] lastObject];
        }

        cell.line.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionLabel.text = riskModel.questionA;
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_a_on"] forState:UIControlStateNormal];
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_a"] forState:UIControlStateSelected];
        [cell.questionBtn setSelected:YES];
        return cell;
    }else if (indexPath.row == 2)
    {
//        JSGotoRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:question];
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        

        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSGotoRiskCell class]) owner:nil options:nil] lastObject];
        }
        cell.line.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionLabel.text = riskModel.questionB;
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_b_on"] forState:UIControlStateNormal];
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_b"] forState:UIControlStateSelected];
        return cell;
    }else if (indexPath.row == 3)
    {
//        JSGotoRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:question];
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        

        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSGotoRiskCell class]) owner:nil options:nil] lastObject];
        }
        cell.line.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionLabel.text = riskModel.questionC;
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_c_on"] forState:UIControlStateNormal];
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_c"] forState:UIControlStateSelected];
        return cell;
        
    }else if (indexPath.row == 4)
    {
//        JSGotoRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:question];
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        

        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSGotoRiskCell class]) owner:nil options:nil] lastObject];
        }
        if (indexPath.section == 8)
        {
            cell.line.hidden = YES;
        }else
        {
            cell.line.hidden = NO;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionLabel.text = riskModel.questionD;
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_d_on"] forState:UIControlStateNormal];
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_d"] forState:UIControlStateSelected];
        return cell;
    }else
    {
//        JSGotoRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:question];
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        

        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSGotoRiskCell class]) owner:nil options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionLabel.text = riskModel.questionE;
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_e_on"] forState:UIControlStateNormal];
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_e"] forState:UIControlStateSelected];
        return cell;
    }

}
- (UITableViewCell *)SelectCellTwoView:(NSIndexPath *)indexPath andTableView:(UITableView *)tableView andRiskModel:(JSRiskEvaluateModel *)riskModel
{
    if (indexPath.row == 0)
    {
        JSGotoRiskQuestionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:questionTitle];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionTitleStr = riskModel.questionTitle;
        return cell;
    }else if (indexPath.row == 1)
    {
        
        
//        JSGotoRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:question];
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        

        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSGotoRiskCell class]) owner:nil options:nil] lastObject];
        }
        cell.line.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionLabel.text = riskModel.questionA;
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_a_on"] forState:UIControlStateNormal];
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_a"] forState:UIControlStateSelected];
        return cell;
    }else if (indexPath.row == 2)
    {
//        JSGotoRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:question];
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        

        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSGotoRiskCell class]) owner:nil options:nil] lastObject];
        }
        cell.line.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionLabel.text = riskModel.questionB;
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_b_on"] forState:UIControlStateNormal];
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_b"] forState:UIControlStateSelected];
        [cell.questionBtn setSelected:YES];
        return cell;
    }else if (indexPath.row == 3)
    {
//        JSGotoRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:question];
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        

        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSGotoRiskCell class]) owner:nil options:nil] lastObject];
        }
        cell.line.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionLabel.text = riskModel.questionC;
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_c_on"] forState:UIControlStateNormal];
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_c"] forState:UIControlStateSelected];
        return cell;
        
    }else if (indexPath.row == 4)
    {
//        JSGotoRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:question];
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        

        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSGotoRiskCell class]) owner:nil options:nil] lastObject];
        }
        if (indexPath.section == 8)
        {
            cell.line.hidden = YES;
        }else
        {
            cell.line.hidden = NO;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionLabel.text = riskModel.questionD;
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_d_on"] forState:UIControlStateNormal];
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_d"] forState:UIControlStateSelected];
        return cell;
    }else
    {
//        JSGotoRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:question];
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        

        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSGotoRiskCell class]) owner:nil options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionLabel.text = riskModel.questionE;
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_e_on"] forState:UIControlStateNormal];
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_e"] forState:UIControlStateSelected];
        return cell;
    }
    

}
- (UITableViewCell *)SelectCellThreeView:(NSIndexPath *)indexPath andTableView:(UITableView *)tableView andRiskModel:(JSRiskEvaluateModel *)riskModel
{
    if (indexPath.row == 0)
    {
        JSGotoRiskQuestionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:questionTitle];
        
        cell.questionTitleStr = riskModel.questionTitle;
        return cell;
    }else if (indexPath.row == 1)
    {
        
        
//        JSGotoRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:question];
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        

        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSGotoRiskCell class]) owner:nil options:nil] lastObject];
        }
        cell.line.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionLabel.text = riskModel.questionA;
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_a_on"] forState:UIControlStateNormal];
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_a"] forState:UIControlStateSelected];
        return cell;
    }else if (indexPath.row == 2)
    {
//        JSGotoRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:question];
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        

        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSGotoRiskCell class]) owner:nil options:nil] lastObject];
        }
        cell.line.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionLabel.text = riskModel.questionB;
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_b_on"] forState:UIControlStateNormal];
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_b"] forState:UIControlStateSelected];
        return cell;
    }else if (indexPath.row == 3)
    {
//        JSGotoRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:question];
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        

        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSGotoRiskCell class]) owner:nil options:nil] lastObject];
        }
        cell.line.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionLabel.text = riskModel.questionC;
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_c_on"] forState:UIControlStateNormal];
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_c"] forState:UIControlStateSelected];
        [cell.questionBtn setSelected:YES];
        return cell;
        
    }else if (indexPath.row == 4)
    {
//        JSGotoRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:question];
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        

        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSGotoRiskCell class]) owner:nil options:nil] lastObject];
        }
        if (indexPath.section == 8)
        {
            cell.line.hidden = YES;
        }else
        {
            cell.line.hidden = NO;
        }

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionLabel.text = riskModel.questionD;
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_d_on"] forState:UIControlStateNormal];
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_d"] forState:UIControlStateSelected];
        return cell;
    }else
    {
//        JSGotoRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:question];
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        

        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSGotoRiskCell class]) owner:nil options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionLabel.text = riskModel.questionE;
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_e_on"] forState:UIControlStateNormal];
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_e"] forState:UIControlStateSelected];
        return cell;
    }
    

}
- (UITableViewCell *)SelectCellForeView:(NSIndexPath *)indexPath andTableView:(UITableView *)tableView andRiskModel:(JSRiskEvaluateModel *)riskModel
{
    if (indexPath.row == 0)
    {
        JSGotoRiskQuestionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:questionTitle];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionTitleStr = riskModel.questionTitle;
        return cell;
    }else if (indexPath.row == 1)
    {
        
        
//        JSGotoRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:question];
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        

        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSGotoRiskCell class]) owner:nil options:nil] lastObject];
        }
        cell.line.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionLabel.text = riskModel.questionA;
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_a_on"] forState:UIControlStateNormal];
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_a"] forState:UIControlStateSelected];
        return cell;
    }else if (indexPath.row == 2)
    {
//        JSGotoRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:question];
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        

        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSGotoRiskCell class]) owner:nil options:nil] lastObject];
        }
        cell.line.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionLabel.text = riskModel.questionB;
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_b_on"] forState:UIControlStateNormal];
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_b"] forState:UIControlStateSelected];
        return cell;
    }else if (indexPath.row == 3)
    {
//        JSGotoRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:question];
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        

        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSGotoRiskCell class]) owner:nil options:nil] lastObject];
        }
        cell.line.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionLabel.text = riskModel.questionC;
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_c_on"] forState:UIControlStateNormal];
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_c"] forState:UIControlStateSelected];
        return cell;
        
    }else if (indexPath.row == 4)
    {
//        JSGotoRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:question];
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        

        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSGotoRiskCell class]) owner:nil options:nil] lastObject];
        }
        if (indexPath.section == 8)
        {
            cell.line.hidden = YES;
        }else
        {
            cell.line.hidden = NO;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionLabel.text = riskModel.questionD;
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_d_on"] forState:UIControlStateNormal];
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_d"] forState:UIControlStateSelected];
        [cell.questionBtn setSelected:YES];
        return cell;
    }else
    {
//        JSGotoRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:question];
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        

        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSGotoRiskCell class]) owner:nil options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionLabel.text = riskModel.questionE;
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_e_on"] forState:UIControlStateNormal];
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_e"] forState:UIControlStateSelected];
        return cell;
    }
    

}
- (UITableViewCell *)SelectCellFiveView:(NSIndexPath *)indexPath andTableView:(UITableView *)tableView andRiskModel:(JSRiskEvaluateModel *)riskModel
{
    if (indexPath.row == 0)
    {
        JSGotoRiskQuestionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:questionTitle];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionTitleStr = riskModel.questionTitle;
        return cell;
    }else if (indexPath.row == 1)
    {
        
        
//        JSGotoRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:question];
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        

        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSGotoRiskCell class]) owner:nil options:nil] lastObject];
        }
        cell.line.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionLabel.text = riskModel.questionA;
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_a_on"] forState:UIControlStateNormal];
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_a"] forState:UIControlStateSelected];
        return cell;
    }else if (indexPath.row == 2)
    {
//        JSGotoRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:question];
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        

        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSGotoRiskCell class]) owner:nil options:nil] lastObject];
        }
        cell.line.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionLabel.text = riskModel.questionB;
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_b_on"] forState:UIControlStateNormal];
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_b"] forState:UIControlStateSelected];
        return cell;
    }else if (indexPath.row == 3)
    {
//        JSGotoRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:question];
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        

        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSGotoRiskCell class]) owner:nil options:nil] lastObject];
        }
        cell.line.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionLabel.text = riskModel.questionC;
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_c_on"] forState:UIControlStateNormal];
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_c"] forState:UIControlStateSelected];
        return cell;
        
    }else if (indexPath.row == 4)
    {
//        JSGotoRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:question];
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        

        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSGotoRiskCell class]) owner:nil options:nil] lastObject];
        }
        if (indexPath.section == 8)
        {
            cell.line.hidden = YES;
        }else
        {
            cell.line.hidden = NO;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionLabel.text = riskModel.questionD;
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_d_on"] forState:UIControlStateNormal];
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_d"] forState:UIControlStateSelected];
        return cell;
    }else
    {
//        JSGotoRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:question];
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        

        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSGotoRiskCell class]) owner:nil options:nil] lastObject];
        }
        cell.line.hidden = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.questionLabel.text = riskModel.questionE;
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_e_on"] forState:UIControlStateNormal];
        [cell.questionBtn setImage:[UIImage imageNamed:@"icon_e"] forState:UIControlStateSelected];
        [cell.questionBtn setSelected:YES];
        return cell;
    }
    

}

- (void)changedidSelectCellNomaltableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath
{
    
    JSRiskEvaluateModel *riskModel = _dataArray[indexPath.section];
    NSMutableDictionary *cellMarkDic = [NSMutableDictionary dictionary];
    
    // 取消前一个选中的，就是单选啦
    NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:_index inSection:indexPath.section];
    // 前一个选中的为第一个
    if (lastIndex.row == 1)
    {
        JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
        [lastCell.questionBtn setSelected:NO];
        
    }else if (lastIndex.row == 2)
    {
        JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
        [lastCell.questionBtn setSelected:NO];
    }else if (lastIndex.row == 3)
    {
        JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
        [lastCell.questionBtn setSelected:NO];
    }else if (lastIndex.row == 4)
    {
        JSGotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
        [lastCell.questionBtn setSelected:NO];
    }
    
    JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell.questionBtn setSelected:YES];
    
    // 保存选中的
    _index = indexPath.row;
    
    [self.tableView performSelector:@selector(deselectRowAtIndexPath:animated:) withObject:indexPath afterDelay:.5];
    
    NSLog(@"_index = %ld", _index);
    
    
    if (indexPath.row == 0)
    {
        
    }else if (indexPath.row == 1)
    {
        self.score1 = riskModel.scoreA;
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell.questionBtn setSelected:YES];
        
        
        [cellMarkDic setObject:@"1" forKey:@"0"];
        
        
    }else if (indexPath.row == 2)
    {
        self.score1 = riskModel.scoreB;
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell.questionBtn setSelected:YES];
        [cellMarkDic setObject:@"2" forKey:@"0"];
        
    }else if (indexPath.row == 3)
    {
        self.score1 = riskModel.scoreC;
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell.questionBtn setSelected:YES];
        [cellMarkDic setObject:@"3" forKey:@"0"];
        
    }else if (indexPath.row == 4)
    {
        self.score1 = riskModel.scoreD;
        JSGotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell.questionBtn setSelected:YES];
        [cellMarkDic setObject:@"4" forKey:@"0"];
        
    }
    
//    [self.cellMarkArray insertObject:cellMarkDic atIndex:0];
    [self.cellMarkArray replaceObjectAtIndex:0 withObject:cellMarkDic];
}

@end

