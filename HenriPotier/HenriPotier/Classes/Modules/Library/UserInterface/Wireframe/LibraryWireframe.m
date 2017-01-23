//
//  LibraryWireframe.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "LibraryWireframe.h"

#import "LibraryViewController.h"
#import "LibraryPresenter.h"

#import "CartWireframe.h"
#import "RootWireframe.h"

static NSString *LibraryViewControllerIdentifier = @"LibraryViewController";

@interface LibraryWireframe ()
@property (nonatomic, strong) LibraryViewController *libraryViewController;
@end

@implementation LibraryWireframe

- (void)presentLibraryInterfaceFromWindow:(UIWindow *)window
{
    LibraryViewController *libraryViewController = [self libraryViewControllerFromStoryboard];
    libraryViewController.eventHandler = self.libraryPresenter;
    self.libraryPresenter.userInterface = libraryViewController;
    self.libraryViewController = libraryViewController;

    [self.rootWireframe showRootViewController:libraryViewController inWindow:window];
}


- (void)presentCartInterface
{
    [self.cartWireframe presentCartInterfaceFromViewController:self.libraryViewController];
}


- (LibraryViewController *)libraryViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self mainStoryboard];
    LibraryViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:LibraryViewControllerIdentifier];

    return viewController;
}


- (UIStoryboard *)mainStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];

    return storyboard;
}

@end
