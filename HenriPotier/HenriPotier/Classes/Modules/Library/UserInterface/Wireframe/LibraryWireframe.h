//
//  LibraryWireframe.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootWireframe;
@class CartWireframe;
@class LibraryPresenter;

@interface LibraryWireframe : NSObject

@property (nonatomic, strong) RootWireframe *rootWireframe;
@property (nonatomic, strong) CartWireframe *cartWireframe;
@property (nonatomic, strong) LibraryPresenter *libraryPresenter;

- (void)presentLibraryInterfaceFromWindow:(UIWindow *)window;
- (void)presentCartInterface;

@end
