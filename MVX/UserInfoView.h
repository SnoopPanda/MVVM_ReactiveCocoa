//
//  UserView.h
//  MVX
//
//  Created by 王杰 on 2020/9/21.
//  Copyright © 2020 SPPT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface UserInfoView : UIView

- (instancetype)initWithViewModel:(UserViewModel *)viewModel;
- (void)bindData;

@end

NS_ASSUME_NONNULL_END
