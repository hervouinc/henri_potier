//
//  CartItemViewCell.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 22/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartItemViewCell : UITableViewCell

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *totalPrice;
@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, strong) NSString *imageName;

- (void)addPlusButtonTarget:(id)target action:(SEL)action;
- (void)addMinusButtonTarget:(id)target action:(SEL)action;

@end
