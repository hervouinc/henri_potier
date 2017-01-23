//
//  LibraryInteractor.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "LibraryInteractor.h"
#import "LibraryDataManager.h"
#import "BookItem.h"

@interface LibraryInteractor()
@property (nonatomic, strong) LibraryDataManager *dataManager;
@end

@implementation LibraryInteractor

- (instancetype)initWithDataManager:(LibraryDataManager *)dataManager
{
    self = [super init];
    if (!self) return nil;

    self.dataManager = dataManager;

    return self;
}

- (void)findBookItems
{
    __weak typeof(self) welf = self;

    [self.dataManager bookItemsWithCompletionBlock:^(NSArray<BookItem*> *bookItems) {

        [welf.output foundBookItems:bookItems];

        [bookItems enumerateObjectsUsingBlock:^(BookItem*  _Nonnull bookItem, NSUInteger idx, BOOL * _Nonnull stop) {
            if(bookItem.imageName == nil)
            {
                [self.dataManager addCoverImageToBookItemWithIsbn:bookItem.isbn completionBlock:^(BookItem *item) {
                    [welf.output updatedBookItem:item];
                }];
            }
        }];
    }];
}

#pragma mark - AppReachability Events
- (void)reachabilityDidChange:(BOOL)reachable
{
    if(reachable)
    {
        [self findBookItems];
    }
}


@end
