//
//  BlogCellViewModel.h
//  MVX
//
//  Created by 王杰 on 2020/9/22.
//  Copyright © 2020 SPPT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlogModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface BlogCellViewModel : NSObject

- (BlogModel *)blog;

- (BOOL)isLiked;
- (NSString *)blogTitleText;
- (NSString *)blogSummaryText;
- (NSString *)blogLikeCount;
- (NSString *)blogShareCount;

- (RACCommand *)likeBlogCommand;
//- (RACCommand *)shareBlogCommand;

- (instancetype)initWithBlog:(BlogModel *)blog;

@end

NS_ASSUME_NONNULL_END
