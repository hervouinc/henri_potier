//
//  CartWireframe.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CartPresenter;

@interface CartWireframe : NSObject

@property (nonatomic, strong) CartPresenter *cartPresenter;

- (void)presentCartInterfaceFromViewController:(UIViewController *)viewController;
- (void)dismissCartInterface;

@end
