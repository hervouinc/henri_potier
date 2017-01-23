//
//  CartDisplayItem.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 22/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CartDisplayItem : NSObject

@property (nonatomic, readonly, copy)   NSString*   title;
@property (nonatomic, readonly, copy)   NSString*   isbn;
@property (nonatomic, readonly, copy)   NSString*   totalPrice;
@property (nonatomic, readonly, copy)   NSString*   imageName;
@property (nonatomic, readonly, copy)   NSNumber*   count;

+ (instancetype)cartDisplayItemWithTitle:(NSString*)title isbn:(NSString*)isbn totalPrice:(NSString*)totalPrice imageName:(NSString*)imageName count:(NSNumber*)count ;

- (NSComparisonResult)compare:(CartDisplayItem *)object;

@end
