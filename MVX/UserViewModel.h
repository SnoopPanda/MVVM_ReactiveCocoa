//
//  UserViewModel.h
//  MVX
//
//  Created by 王杰 on 2020/9/21.
//  Copyright © 2020 SPPT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "UserModel.h"
#import "BlogCellViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserViewModel : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *summary;
@property (copy, nonatomic) NSString *blogCount;
@property (copy, nonatomic) NSString *friendCount;

@property (strong, nonatomic) UserModel *user;
@property (assign, nonatomic) NSUInteger userId;

@property (strong, nonatomic) NSMutableArray<BlogCellViewModel *> *blogsArray;

@property (strong, nonatomic) RACSignal *refreshDataSignal;
@property (strong, nonatomic) RACSignal *loadMoreDataSignal;

+ (instancetype)viewModelWithUserId:(NSUInteger)userId;

- (RACCommand *)fetchUserInfoCommand;

@end

NS_ASSUME_NONNULL_END
