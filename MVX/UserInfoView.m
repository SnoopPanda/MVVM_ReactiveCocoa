//
//  UserView.m
//  MVX
//
//  Created by 王杰 on 2020/9/21.
//  Copyright © 2020 SPPT. All rights reserved.
//

#import "UserInfoView.h"
#import <Masonry/Masonry.h>

@interface UserInfoView ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *blogCountLabel;
@property (nonatomic, strong) UILabel *friendCountLabel;
@property (nonatomic, strong) UILabel *detailLabel;

@property (nonatomic, strong) UserViewModel *viewModel;
@end

@implementation UserInfoView

- (instancetype)initWithViewModel:(UserViewModel *)viewModel {
    if (self = [super init]) {
        self.backgroundColor = [UIColor cyanColor];
        self.viewModel = viewModel;
        
        [self addSubview:self.nameLabel];
        [self addSubview:self.blogCountLabel];
        [self addSubview:self.friendCountLabel];
        [self addSubview:self.detailLabel];
        [self layoutContentView];
    }
    return self;
}

- (void)bindData {
    RAC(self.nameLabel, text) = RACObserve(self.viewModel, name);
    RAC(self.blogCountLabel, text) = RACObserve(self, viewModel.blogCount);
    RAC(self.friendCountLabel, text) = RACObserve(self, viewModel.friendCount);
    RAC(self.detailLabel, text) = RACObserve(self, viewModel.summary);
}

- (void)layoutContentView {
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(10);
    }];
    
    [self.blogCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
    }];
    
    [self.friendCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(self.blogCountLabel.mas_bottom).offset(10);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(self.friendCountLabel.mas_bottom).offset(10);
    }];
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"-";
        _nameLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightBold];
    }
    return _nameLabel;
}

- (UILabel *)blogCountLabel {
    if (!_blogCountLabel) {
        _blogCountLabel = [[UILabel alloc] init];
        _blogCountLabel.text = @"博客数：0";
        _blogCountLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    }
    return _blogCountLabel;
}

- (UILabel *)friendCountLabel {
    if (!_friendCountLabel) {
        _friendCountLabel = [[UILabel alloc] init];
        _friendCountLabel.text = @"好友数：0";
        _friendCountLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    }
    return _friendCountLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.text = @"个人简介：-";
        _detailLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    }
    return _detailLabel;
}

@end
