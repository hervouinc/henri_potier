//
//  LibraryDisplayData.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "LibraryDisplayData.h"
#import "LibraryDisplayItem.h"

@interface LibraryDisplayData()
@property (nonatomic, copy) NSArray<LibraryDisplayItem *>* items;
@end

@implementation LibraryDisplayData

+ (instancetype)libraryDisplayDataWithItems:(NSArray<LibraryDisplayItem *> *)items
{
    LibraryDisplayData* data = [[LibraryDisplayData alloc] init];

    data.items = [items sortedArrayUsingComparator:^NSComparisonResult(LibraryDisplayItem*  _Nonnull obj1, LibraryDisplayItem*  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];

    return data;
}

- (BOOL)isEqualToLibraryDisplayData:(LibraryDisplayData *)data
{
    if (!data)
    {
        return NO;
    }

    BOOL hasEqualItems = [self.items isEqualToArray:data.items];

    return hasEqualItems;
}

- (BOOL)isEqual:(id)object
{
    if (self == object)
    {
        return YES;
    }

    if (![object isKindOfClass:[LibraryDisplayData class]])
    {
        return NO;
    }

    return [self isEqualToLibraryDisplayData:object];
}

- (NSUInteger)hash
{
    return self.items.hash;
}

@end
