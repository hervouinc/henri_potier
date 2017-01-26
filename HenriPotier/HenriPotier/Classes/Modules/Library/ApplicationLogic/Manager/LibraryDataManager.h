//
//  LibraryDataManager.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RemoteDataStore;
@class LocalDataStore;
@class LocalCachedDataStore;
@class BookItem;

typedef void(^LibraryDataManagerItemsCompletionBlock)(NSArray<BookItem*> *results, NSError *error);
typedef void(^LibraryDataManagerItemCompletionBlock)(BookItem *item);

@interface LibraryDataManager : NSObject

@property (nonatomic, strong) RemoteDataStore *remoteDataStore;
@property (nonatomic, strong) LocalDataStore *localDataStore;
@property (nonatomic, strong) LocalCachedDataStore *localCachedDataStore;

- (void)bookItemsWithCompletionBlock:(LibraryDataManagerItemsCompletionBlock)completionBlock;
- (void)addCoverImageToBookItemWithIsbn:(NSString *)isbn completionBlock:(LibraryDataManagerItemCompletionBlock)completionBlock;

@end
