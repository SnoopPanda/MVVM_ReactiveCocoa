//
//  BlogCell.m
//  MVX
//
//  Created by 王杰 on 2020/9/22.
//  Copyright © 2020 SPPT. All rights reserved.
//

#import "BlogCell.h"
#import <Masonry/Masonry.h>

@interface BlogCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *summaryLabel;
@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@end

@implementation BlogCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.summaryLabel];
        [self addSubview:self.likeBtn];
        [self addSubview:self.shareBtn];
        [self layoutContentView];
        [self bindData];
    }
    return self;
}

- (void)bindData {
    @weakify(self);
    RAC(self.titleLabel, text) = RACObserve(self, viewModel.blogTitleText);
    RAC(self.summaryLabel, text) = RACObserve(self, viewModel.blogSummaryText);
    RAC(self.likeBtn, selected) = [RACObserve(self, viewModel.isLiked) ignore:nil];
    [RACObserve(self, viewModel.blogLikeCount) subscribeNext:^(NSString *title) {
        @strongify(self);
        [self.likeBtn setTitle:title forState:UIControlStateNormal];
    }];
    [RACObserve(self, viewModel.blogShareCount) subscribeNext:^(NSString *title) {
        @strongify(self);
        [self.shareBtn setTitle:title forState:UIControlStateNormal];
    }];
}

- (void)layoutContentView {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.equalTo(self);
    }];
    
    [self.summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(90);
        make.centerY.equalTo(self);
    }];
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.top.bottom.offset(0);
        make.width.mas_equalTo(60);
    }];
    
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.shareBtn.mas_left);
        make.top.bottom.offset(0);
        make.width.mas_equalTo(60);
    }];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"-";
        _titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    }
    return _titleLabel;
}

- (UILabel *)summaryLabel {
    if (!_summaryLabel) {
        _summaryLabel = [[UILabel alloc] init];
        _summaryLabel.text = @"-";
        _summaryLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    }
    return _summaryLabel;
}

- (UIButton *)likeBtn {
    if (!_likeBtn) {
        _likeBtn = [[UIButton alloc] init];
        [_likeBtn setTitle:@"点赞" forState:UIControlStateNormal];
        [_likeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _likeBtn.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    }
    return _likeBtn;
}

- (UIButton *)shareBtn {
    if (!_shareBtn) {
        _shareBtn = [[UIButton alloc] init];
        [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        [_shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _shareBtn.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    }
    return _shareBtn;
}

@end
