//
//  LibraryViewController.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LibraryViewInterface.h"
#import "LibraryModuleInterface.h"

@interface LibraryViewController : UIViewController <LibraryViewInterface>

@property (nonatomic, strong) id<LibraryModuleInterface>    eventHandler;

@end
