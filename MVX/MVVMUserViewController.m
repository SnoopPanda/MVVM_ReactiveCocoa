//
//  MVVMUserViewController.m
//  MVX
//
//  Created by 王杰 on 2020/9/21.
//  Copyright © 2020 SPPT. All rights reserved.
//

#import "MVVMUserViewController.h"
#import "UserInfoView.h"
#import <Masonry/Masonry.h>
#import "UIView+Alert.h"
#import "BlogCell.h"
#import <MJRefresh/MJRefresh.h>

@interface MVVMUserViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) NSUInteger userId;
@property (nonatomic, strong) UserInfoView *userView;
@property (nonatomic, strong) UserViewModel *userViewModel;

@property (nonatomic, strong) UITableView *listView;

@end

@implementation MVVMUserViewController

- (instancetype)initWithUserId:(NSUInteger)userId {
    if (self = [super init]) {
        self.userId = userId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    
    [self setupUI];
    [self bindData];
    [self fetchData];
}

- (void)setupUI {
    [self.view addSubview:self.userView];
    [self.view addSubview:self.listView];
    [self layoutContentView];
}

- (void)layoutContentView {
    [self.userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.mas_equalTo(120);
    }];
    
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.equalTo(self.userView.mas_bottom);
    }];
}

- (void)bindData {
    [self.userView bindData];
}

- (void)fetchData {
    [self showHUD];
    [[[self.userViewModel fetchUserInfoCommand] execute:nil] subscribeError:^(NSError *error) {
        NSLog(@"%@", error);
    } completed:^{
        NSLog(@"completed");
    }];
    
    [self.userViewModel.refreshDataSignal subscribeError:^(NSError *error) {
        [self hideHUD];
    } completed:^{
         [self.listView reloadData];
        [self hideHUD];
    }];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userViewModel.blogsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BlogCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BlogCell" forIndexPath:indexPath];
    cell.viewModel = self.userViewModel.blogsArray[indexPath.row];
    return cell;
}

#pragma mark - Lazy load

- (UserInfoView *)userView {
    if (!_userView) {
        _userView = [[UserInfoView alloc] initWithViewModel:self.userViewModel];
    }
    return _userView;
}

- (UserViewModel *)userViewModel {
    if (!_userViewModel) {
        _userViewModel = [UserViewModel viewModelWithUserId:self.userId];
    }
    return _userViewModel;
}

- (UITableView *)listView {
    if (!_listView) {
        _listView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_listView registerClass:[BlogCell class] forCellReuseIdentifier:@"BlogCell"];
        _listView.delegate = self;
        _listView.dataSource = self;
        
        _listView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.userViewModel.refreshDataSignal subscribeError:^(NSError *error) {
                [self.listView.header endRefreshing];
            } completed:^{
                [self.listView reloadData];
                [self.listView.header endRefreshing];
                [self.listView.footer resetNoMoreData];
            }];
        }];
        
        _listView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                [self.userViewModel.loadMoreDataSignal subscribeError:^(NSError *error) {
                    
                    [self.listView.footer endRefreshing];
//                    [self.listView showToastWithText:error.domain];
                    [self.listView.footer endRefreshingWithNoMoreData];
                } completed:^{
                    [self.listView reloadData];
                    [self.listView.footer endRefreshing];
                }];
            }];

    }
    return _listView;
}

@end
