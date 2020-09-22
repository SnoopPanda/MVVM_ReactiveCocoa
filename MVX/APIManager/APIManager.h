//
//  APIManager.h
//  MVX
//
//  Created by 王杰 on 2020/9/21.
//  Copyright © 2020 SPPT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NetworkCompletionHandler)(NSError *error, id result);
typedef UIViewController *(^ViewControllerGenerator)(id params);//为了方便 但实际开发肯定不会定义在API里面

typedef enum : NSUInteger {
    NetworkErrorNoData,
    NetworkErrorNoMoreData
} NetworkError;

@interface APIManager : NSObject
//假装我有一堆网络请求 其实并没有
- (void)fetchUserInfoWithUserId:(NSUInteger)userId completionHandler:(NetworkCompletionHandler)completionHandler;

- (void)refreshUserDraftsWithUserId:(NSUInteger)userId completionHandler:(NetworkCompletionHandler)completionHandler;
- (void)loadModeUserDraftsWithUserId:(NSUInteger)userId completionHandler:(NetworkCompletionHandler)completionHandler;
- (void)deleteDraftWithDraftId:(NSUInteger)draftId completionHandler:(NetworkCompletionHandler)completionHandler;

- (void)refreshUserBlogsWithUserId:(NSUInteger)userId completionHandler:(NetworkCompletionHandler)completionHandler;
- (void)loadModeUserBlogsWithUserId:(NSUInteger)userId completionHandler:(NetworkCompletionHandler)completionHandler;
- (void)likeBlogWithBlogId:(NSUInteger)blogId completionHandler:(NetworkCompletionHandler)completionHandler;

@end
