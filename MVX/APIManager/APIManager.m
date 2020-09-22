//
//  APIManager.m
//  MVX
//
//  Created by 王杰 on 2020/9/21.
//  Copyright © 2020 SPPT. All rights reserved.
//

#import "APIManager.h"

#import "UserModel.h"
#import "BlogModel.h"
#import "DraftModel.h"

@interface APIManager ()

@property (assign, nonatomic) NSUInteger blogPage;
@property (assign, nonatomic) NSUInteger draftPage;

@end

#define PageSize 20

@implementation APIManager

- (void)fetchUserInfoWithUserId:(NSUInteger)userId completionHandler:(NetworkCompletionHandler)completionHandler {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        !completionHandler ?: completionHandler(nil, [[UserModel alloc] initWithUserId:userId]);
    });
}

- (void)refreshUserDraftsWithUserId:(NSUInteger)userId completionHandler:(NetworkCompletionHandler)completionHandler {
    
    self.draftPage = 0;
    [self fetchUserDraftsWithUserId:userId page:self.draftPage pageSize:PageSize completionHandler:completionHandler];
}

- (void)loadModeUserDraftsWithUserId:(NSUInteger)userId completionHandler:(NetworkCompletionHandler)completionHandler {
    
    self.draftPage += 1;
    [self fetchUserDraftsWithUserId:userId page:self.draftPage pageSize:PageSize completionHandler:completionHandler];
}

- (void)refreshUserBlogsWithUserId:(NSUInteger)userId completionHandler:(NetworkCompletionHandler)completionHandler {
    
    self.blogPage = 0;
    [self fetchUserBlogsWithUserId:userId page:self.blogPage pageSize:PageSize completionHandler:completionHandler];
}

- (void)loadModeUserBlogsWithUserId:(NSUInteger)userId completionHandler:(NetworkCompletionHandler)completionHandler {
    
    self.blogPage += 1;
    [self fetchUserBlogsWithUserId:userId page:self.blogPage pageSize:PageSize completionHandler:completionHandler];
}

- (void)likeBlogWithBlogId:(NSUInteger)blogId completionHandler:(NetworkCompletionHandler)completionHandler {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSError *error = arc4random() % 2 ? [NSError errorWithDomain:@"点赞失败" code:123 userInfo:nil] : nil;
        !completionHandler ?: completionHandler(error, nil);
    });
}

- (void)deleteDraftWithDraftId:(NSUInteger)draftId completionHandler:(NetworkCompletionHandler)completionHandler {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSError *error = draftId % 2 == 0 ? [NSError errorWithDomain:@"服务器繁忙, 请稍后再试~" code:123 userInfo:nil] : nil;
        !completionHandler ?: completionHandler(error, nil);
    });
}

#pragma mark - Utils

- (void)fetchUserBlogsWithUserId:(NSUInteger)userId page:(NSUInteger)page pageSize:(NSUInteger)pageSize completionHandler:(NetworkCompletionHandler)completionHandler {
    
    NSUInteger delayTime = page == 0 ? 1.5 : 1;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (page >= 2) {
            !completionHandler ?: completionHandler([NSError errorWithDomain:@"没有更多了" code:NetworkErrorNoMoreData userInfo:nil], nil);
        } else {
            
            NSMutableArray *blogs = [NSMutableArray array];
            for (int i = 0; i < pageSize; i ++) {
                [blogs addObject:[[BlogModel alloc] initWithBlogId:pageSize * page + i]];
            }
            !completionHandler ?: completionHandler(nil, blogs);
        }
    });
}

- (void)fetchUserDraftsWithUserId:(NSUInteger)userId page:(NSUInteger)page pageSize:(NSUInteger)pageSize completionHandler:(NetworkCompletionHandler)completionHandler {
    
    NSUInteger delayTime = page == 0 ? 1.5 : 1;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (page >= 1) {
            !completionHandler ?: completionHandler([NSError errorWithDomain:@"没有更多了" code:NetworkErrorNoMoreData userInfo:nil], nil);
        } else {
            
            NSMutableArray *blogs = [NSMutableArray array];
            for (int i = 0; i < pageSize; i ++) {
                [blogs addObject:[[DraftModel alloc] initWithDraftId:pageSize * page + i]];
            }
            !completionHandler ?: completionHandler(nil, blogs);
        }
    });
}

@end
