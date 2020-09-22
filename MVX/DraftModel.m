//
//  DraftModel.m
//  MVX
//
//  Created by 王杰 on 2020/9/21.
//  Copyright © 2020 SPPT. All rights reserved.
//

#import "DraftModel.h"

@implementation DraftModel

- (instancetype)initWithDraftId:(NSUInteger)draftId {
    
    self.draftId = draftId;
    self.draftTitle = [NSString stringWithFormat:@"draftTitle%ld", draftId];
    self.draftSummary = [NSString stringWithFormat:@"draftSummary%ld", draftId];
    self.editDate = [[NSDate date] timeIntervalSince1970] + arc4random() % 200;
    
    return self;
}

@end
