//
//  BlogCell.h
//  MVX
//
//  Created by 王杰 on 2020/9/22.
//  Copyright © 2020 SPPT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlogCellViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BlogCell : UITableViewCell
@property (strong, nonatomic) BlogCellViewModel *viewModel;
@end

NS_ASSUME_NONNULL_END
