//
//  BlogModel.m
//  MVX
//
//  Created by 王杰 on 2020/9/21.
//  Copyright © 2020 SPPT. All rights reserved.
//

#import "BlogModel.h"

@implementation BlogModel

- (instancetype)initWithBlogId:(NSUInteger)blogId {
    
    self.blogId = blogId;
    self.isLiked = blogId % 2;
    self.likeCount = blogId + 10;
    self.blogTitle = [NSString stringWithFormat:@"blogTitle%ld", blogId];
    self.shareCount = blogId + 8;
    self.blogSummary = [NSString stringWithFormat:@"blogSummary%ld", blogId];
    
    return self;
}

@end
