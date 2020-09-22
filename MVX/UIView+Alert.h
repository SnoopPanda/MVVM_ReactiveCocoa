//
//  UIView+Alert.h
//  MVX
//
//  Created by 王杰 on 2020/9/21.
//  Copyright © 2020 SPPT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol Alert <NSObject>

- (void)showHUD;
- (void)showHUDWithText:(NSString *)text;
- (void)hideHUD;

- (void)showToastWithText:(NSString *)toastString;
- (void)showToastWithText:(NSString *)toastString positon:(id)positon;
- (void)showToastWithText:(NSString *)toastString afterDelay:(NSTimeInterval)timeInterval;

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message confirmHandler:(void(^)(UIAlertAction *confirmAction))handler;
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle confirmHandler:(void(^)(UIAlertAction *confirmAction))handler;
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelAction:(UIAlertAction *)cancelAction confirmAction:(UIAlertAction *)confirmAction;

@end

@interface UIView (Alert)

@end

@interface UIViewController (Alert)<Alert>
@end


NS_ASSUME_NONNULL_END
