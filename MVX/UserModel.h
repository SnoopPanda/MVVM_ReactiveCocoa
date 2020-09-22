//
//  User.h
//  MVX
//
//  Created by 王杰 on 2020/9/21.
//  Copyright © 2020 SPPT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject

- (instancetype)initWithUserId:(NSUInteger)userId;

@property (assign, nonatomic) NSUInteger userId;

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *summary;

@property (assign, nonatomic) NSUInteger blogCount;
@property (assign, nonatomic) NSUInteger friendCount;

@end

NS_ASSUME_NONNULL_END
