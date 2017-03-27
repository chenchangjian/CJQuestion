//
//  ViewController.m
//  question
//
//  Created by ccj on 2017/3/27.
//  Copyright © 2017年 ccj. All rights reserved.
//

#import "ViewController.h"
#import "JSGotoRiskTableViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)gotoriskController:(id)sender {
    
    JSGotoRiskTableViewController *risk = [[JSGotoRiskTableViewController alloc] init];
    [self presentViewController:risk animated:YES completion:nil];
}

@end
