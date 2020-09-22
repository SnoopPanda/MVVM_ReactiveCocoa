//
//  MVVMViewController.m
//  MVX
//
//  Created by 王杰 on 2020/9/21.
//  Copyright © 2020 SPPT. All rights reserved.
//

#import "MVVMViewController.h"
#import "MVVMUserViewController.h"

@interface MVVMViewController ()

@end

@implementation MVVMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"MVVM";
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"个人信息" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn sizeToFit];
    btn.center = CGPointMake(self.view.frame.size.width*0.5, self.view.frame.size.height*0.5-100);
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnAction {
    MVVMUserViewController *vc = [[MVVMUserViewController alloc] initWithUserId:18];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
