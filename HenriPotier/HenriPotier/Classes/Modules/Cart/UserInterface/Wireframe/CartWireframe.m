//
//  CartWireframe.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "CartWireframe.h"
#import "CartViewController.h"
#import "CartPresenter.h"

static NSString *CartViewControllerIdentifier = @"CartViewController";

@interface CartWireframe ()
@property (nonatomic, strong) CartViewController *cartViewController;
@end

@implementation CartWireframe

- (void)presentCartInterfaceFromViewController:(UIViewController *)viewController
{
    CartViewController *cartViewController = [self cartViewControllerFromStoryboard];
    cartViewController.eventHandler = self.cartPresenter;
    self.cartPresenter.userInterface = cartViewController;
    self.cartViewController = cartViewController;

    [viewController showViewController:cartViewController sender:self];
}

- (void)dismissCartInterface
{
    [self.cartViewController.navigationController popViewControllerAnimated:YES];
}

- (CartViewController *)cartViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self mainStoryboard];
    CartViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:CartViewControllerIdentifier];

    return viewController;
}


- (UIStoryboard *)mainStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];

    return storyboard;
}

@end
