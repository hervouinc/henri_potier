//
//  LibraryItemView.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LibraryItemViewCell : UITableViewCell

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *imageName;

- (void)addButtonTarget:(id)target action:(SEL)action;

@end
