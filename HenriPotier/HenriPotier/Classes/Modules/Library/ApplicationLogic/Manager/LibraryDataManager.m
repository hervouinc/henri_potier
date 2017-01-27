//
//  LibraryDataManager.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "LibraryDataManager.h"
#import "RemoteDataStore.h"
#import "LocalDataStore.h"
#import "LocalCachedDataStore.h"
#import "BookItem.h"

@implementation LibraryDataManager

- (void)bookItemsWithCompletionBlock:(LibraryDataManagerItemsCompletionBlock)completionBlock
{
    NSArray<BookItem*> *bookItems = [self.localCachedDataStore retrieveBookItems];
    if(bookItems.count > 0)
    {
        completionBlock(bookItems, nil);
        return;
    }

    [self.remoteDataStore fetchBookItemsWithCompletionBlock:^(NSArray<BookItem*> *entries, NSError *error) {
        [self.localCachedDataStore setUpBookItems:entries];
        if (completionBlock)
        {
            completionBlock(entries, error);
        }
    }];
}

- (void)addCoverImageToBookItemWithIsbn:(NSString *)isbn completionBlock:(LibraryDataManagerItemCompletionBlock)completionBlock
{
    BookItem *bookItem = [self.localCachedDataStore bookItemWithIsbn:isbn];
    NSString *coverURL = bookItem.coverURL;
    NSString *imageName = coverURL.lastPathComponent;

    NSURL *tmpDirURL = [NSURL fileURLWithPath:NSTemporaryDirectory() isDirectory:YES];
    NSURL *fileURL = [tmpDirURL URLByAppendingPathComponent:imageName];
    NSString* path = fileURL.path;
    if([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        bookItem.imageName = path.lastPathComponent;
        completionBlock(bookItem);
        return;
    }

    [self.remoteDataStore fetchBookCoverWithURL:coverURL completionBlock:^(NSString *path) {
        bookItem.imageName = path.lastPathComponent;
        completionBlock(bookItem);
    }];
}

@end
