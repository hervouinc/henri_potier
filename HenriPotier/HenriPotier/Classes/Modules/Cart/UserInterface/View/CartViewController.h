//
//  CartViewController.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CartViewInterface.h"
#import "CartModuleInterface.h"

@interface CartViewController : UITableViewController <CartViewInterface>

@property (nonatomic, strong) id<CartModuleInterface> eventHandler;

@end
