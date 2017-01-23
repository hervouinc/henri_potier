//
//  BookItem.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookItem : NSObject

@property (nonatomic, readonly, copy)   NSString*   title;
@property (nonatomic, readonly, copy)   NSString*   isbn;
@property (nonatomic, readonly, copy)   NSNumber*   price;
@property (nonatomic, readonly, copy)   NSString*   coverURL;
@property (nonatomic, strong)           NSString*   imageName;

+ (instancetype)bookItemWithTitle:(NSString*)title isbn:(NSString*)isbn price:(NSNumber*)price coverURL:(NSString*)coverURL;

+ (instancetype)bookItemWithTitle:(NSString*)title isbn:(NSString*)isbn price:(NSNumber*)price imageName:(NSString*)imageName;

@end
