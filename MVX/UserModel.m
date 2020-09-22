//
//  User.m
//  MVX
//
//  Created by 王杰 on 2020/9/21.
//  Copyright © 2020 SPPT. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (instancetype)initWithUserId:(NSUInteger)userId {
    
    self.name = [NSString stringWithFormat:@"user%lu",userId];
    self.userId = userId;
    self.summary = [NSString stringWithFormat:@"userSummary%ld", userId];
    self.blogCount = userId + 8;
    self.friendCount = userId + 10;
    return self;
}

@end
