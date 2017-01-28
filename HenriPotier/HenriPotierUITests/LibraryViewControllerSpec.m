//
//  LibraryViewControllerSpec.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 28/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"

#import <objc/message.h>

#import "AppDependencies.h"
#import "LibraryWireframe.h"
#import "LibraryPresenter.h"
#import "LibraryViewController.h"
#import "CartWireframe.h"
#import "CartPresenter.h"
#import "CartViewController.h"
#import "GoToCartButton.h"

#import "KPAViewControllerTestHelper.h"

@interface AppDependencies (Testing)
@property (nonatomic, strong) LibraryWireframe *libraryWireframe;
@end

@interface LibraryViewController (Testing)
@property (nonatomic, strong) GoToCartButton *goToCartButton;
@end

SpecBegin(ViewControllers)

describe(@"ViewControllers", ^{
    __block AppDependencies *_appDependencies;
    __block LibraryViewController *_libraryViewController;
    __block CartViewController *_cartViewController;

    before(^{
        _appDependencies = [[AppDependencies alloc] init];
        [_appDependencies installRootViewControllerIntoWindow:[[UIApplication sharedApplication] delegate].window];
        _libraryViewController = (LibraryViewController*)_appDependencies.libraryWireframe.libraryPresenter.userInterface;
        _cartViewController = (CartViewController*)_appDependencies.libraryWireframe.cartWireframe.cartPresenter.userInterface;

        [KPAViewControllerTestHelper pushViewController:_libraryViewController];

        expect(_libraryViewController.navigationController.topViewController).to.beKindOf([LibraryViewController class]);
    });

    it(@"pushes cart view controller when the navigation bar cart button is tapped", ^{

        [_libraryViewController.goToCartButton sendActionsForControlEvents:UIControlEventTouchUpInside];

        expect(_libraryViewController.navigationController.topViewController).to.beKindOf([CartViewController class]);
    });
});

SpecEnd
