//
//  RemoteStore.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 22/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BookItem;
@class OfferItem;

typedef void(^RemoteDataStoreFetchOfferItemsCompletionBlock)(NSArray<OfferItem*> *results);
typedef void(^RemoteDataStoreFetchBookItemsCompletionBlock)(NSArray<BookItem*> *results, NSError *error);
typedef void(^RemoteDataStoreFetchImageCompletionBlock)(NSString *path);

@interface RemoteDataStore : NSObject

- (void)fetchBookItemsWithCompletionBlock:(RemoteDataStoreFetchBookItemsCompletionBlock)completionBlock;
- (void)fetchOfferItemsForBookISBNs:(NSArray<NSString*>*)isbns completionBlock:(RemoteDataStoreFetchOfferItemsCompletionBlock)completionBlock;
- (void)fetchBookCoverWithURL:(NSString*)urlStr completionBlock:(RemoteDataStoreFetchImageCompletionBlock)completionBlock;

@end
