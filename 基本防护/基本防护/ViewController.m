//
//  ViewController.m
//  基本防护
//
//  Created by zhihuishequ on 2018/5/27.
//  Copyright © 2018年 WinJayQ. All rights reserved.
//

#import "ViewController.h"

__weak ViewController *wkSelf = nil;
@interface ViewController ()

@end

@implementation ViewController

+(void)load{
    NSLog(@"ViewController--Load");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    wkSelf = self;
    
}

- (IBAction)btnClick1:(id)sender {
    NSLog(@"按钮1调用了!:%@",wkSelf);
    
}
- (IBAction)btnClick2:(id)sender {
    
    NSLog(@"按钮2调用了!");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
