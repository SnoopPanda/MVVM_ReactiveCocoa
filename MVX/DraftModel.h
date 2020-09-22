//
//  DraftModel.h
//  MVX
//
//  Created by 王杰 on 2020/9/21.
//  Copyright © 2020 SPPT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DraftModel : NSObject

- (instancetype)initWithDraftId:(NSUInteger)draftId;

@property (copy, nonatomic) NSString *draftTitle;
@property (copy, nonatomic) NSString *draftSummary;
@property (assign, nonatomic) NSUInteger draftId;
@property (assign, nonatomic) NSUInteger editDate;

@end

NS_ASSUME_NONNULL_END
