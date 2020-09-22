//
//  UserViewModel.m
//  MVX
//
//  Created by 王杰 on 2020/9/21.
//  Copyright © 2020 SPPT. All rights reserved.
//

#import "UserViewModel.h"
#import "APIManager.h"
#import "BlogModel.h"

@interface UserViewModel ()
@property (nonatomic, strong) APIManager *apiManager;
@end

@implementation UserViewModel

+ (instancetype)viewModelWithUserId:(NSUInteger)userId {
    UserViewModel *viewModel = [[UserViewModel alloc] initWithUserId:userId];
    return viewModel;
}

- (instancetype)initWithUserId:(NSUInteger)userId {
    if (self = [super init]) {
        
        self.apiManager = [[APIManager alloc] init];
        
        self.userId = userId;
        self.name = @"-";
        self.summary = @"个人简介: -";
        self.blogCount = @"作品: 0";
        self.friendCount = @"好友: 0";
        
        self.blogsArray = [NSMutableArray array];
    }
    return self;
}

- (void)formatResult:(NSArray *)blogs {
    for (BlogModel *blog in blogs) {
        [self.blogsArray addObject:[[BlogCellViewModel alloc] initWithBlog:blog]];
    }
}

- (RACSignal *)fetchUserInfoSignal {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self.apiManager fetchUserInfoWithUserId:self.userId completionHandler:^(NSError *error, id result) {
            if (error) {
                [subscriber sendError:error];
                return;
            }
            
            [subscriber sendNext:result];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}

- (RACCommand *)fetchUserInfoCommand {
    return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [[self fetchUserInfoSignal] doNext:^(UserModel *user) {
            self.user = user;
            self.name = user.name.length > 0 ? user.name : @"匿名";
            self.summary = [NSString stringWithFormat:@"个人简介: %@", user.summary.length > 0 ? user.summary : @"这个人很懒, 什么也没有写~"];
            self.blogCount = [NSString stringWithFormat:@"作品: %ld", user.blogCount];
            self.friendCount = [NSString stringWithFormat:@"好友: %ld", user.friendCount];
        }];
    }];
}

- (RACSignal *)refreshDataSignal {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self.apiManager refreshUserBlogsWithUserId:self.userId completionHandler:^(NSError *error, id result) {

             if (!error) {
                 [self.blogsArray removeAllObjects];
                 [self formatResult:result];
             }
             error ? [subscriber sendError:error] : [subscriber sendCompleted];
         }];
        return nil;
    }];
}

- (RACSignal *)loadMoreDataSignal {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self.apiManager loadModeUserBlogsWithUserId:self.userId completionHandler:^(NSError *error, id result) {
            error ?: [self formatResult:result];
            error ? [subscriber sendError:error] : [subscriber sendCompleted];
        }];
        return nil;
    }];
}

@end
