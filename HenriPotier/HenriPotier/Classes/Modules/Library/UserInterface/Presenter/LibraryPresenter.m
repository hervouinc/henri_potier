//
//  LibraryPresenter.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "LibraryPresenter.h"
#import "LibraryWireframe.h"
#import "LibraryViewInterface.h"
#import "LibraryDisplayDataCollector.h"
#import "LibraryModuleDelegateInterface.h"
#import "BookItem.h"

@interface LibraryPresenter ()
@property (nonatomic, strong) LibraryDisplayDataCollector *collector;
@end

#pragma mark - LibraryModuleInterface
@implementation LibraryPresenter

- (void)updateView
{
    [self.libraryInteractor findBookItems];
    [self.libraryModuleDelegate libraryModuleAskForCartItemsCount];
}

- (void)goToCart
{
    [self.libraryWireframe presentCartInterface];
}

- (void)addToCartBookWithIsbn:(NSString *)isbn
{
    [self.libraryModuleDelegate libraryModuleAddToCartBookWithIsbn:isbn];
}

#pragma mark - Library Interactor Output

- (void)foundBookItems:(NSArray<BookItem*> *)items
{
    if (items == nil || items.count == 0)
    {
        [self.userInterface showNoContentMessageWithError:nil];
    }
    else
    {
        [self.userInterface showLibraryDisplayData:[self libraryDisplayDataWithBookItems:items]];
    }
}

- (void)foundingBookItemsFailedWithError:(NSError *)error
{
    if([error.domain isEqualToString:NSURLErrorDomain]
       && error.code == NSURLErrorNotConnectedToInternet)
    {
        [self.userInterface showNoContentMessageWithError:@"Verifiez votre connection internet."];
    }
    else
    {
        [self.userInterface showNoContentMessageWithError:error.localizedDescription];
    }
}

- (void)updatedBookItem:(BookItem *)item
{
    [self.userInterface showLibraryDisplayData:[self libraryDisplayDataWithUpdatedBookItem:item]];
}

- (LibraryDisplayData *)libraryDisplayDataWithBookItems:(NSArray *)items
{
    self.collector = [[LibraryDisplayDataCollector alloc] init];
    [self.collector addBookItems:items];

    return [self.collector collectedDisplayData];
}

- (LibraryDisplayData *)libraryDisplayDataWithUpdatedBookItem:(BookItem *)item
{
    [self.collector updateBookItem:item];

    return [self.collector collectedDisplayData];
}

#pragma mark - CartModuleDelegate
- (void)cartModuleDidUpdateCartItemsCount:(int)count
{
    [self.userInterface showNumberOfItemsInCart:count];
}


@end
