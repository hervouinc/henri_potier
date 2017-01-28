//
//  RemoteStore.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 22/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "RemoteDataStore.h"
#import "AFNetworking.h"
#import "BookItem.h"
#import "OfferItem.h"
#import "SliceOfferItem.h"
#import "PercentageOfferItem.h"
#import "MinusOfferItem.h"
#import "OfferType.h"

static NSString* const BooksURL = @"http://henri-potier.xebia.fr/books";
static NSString* const OffersURL = @"http://henri-potier.xebia.fr/books/%@/commercialOffers";

@implementation RemoteDataStore

- (void)fetchBookItemsWithCompletionBlock:(RemoteDataStoreFetchBookItemsCompletionBlock)completionBlock
{
    NSURL *URL = [NSURL URLWithString:BooksURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);

        __block NSMutableArray<BookItem*> *array = [NSMutableArray array];
        [responseObject enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

            BookItem *item = [BookItem bookItemWithTitle:obj[@"title"] isbn:obj[@"isbn"] price:obj[@"price"] coverURL:obj[@"cover"]];
            [array addObject:item];

        }];

        if(completionBlock != nil)
        {
            completionBlock(array, nil);
        }

    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        if(completionBlock != nil)
        {
            completionBlock(@[], error);
        }
    }];
}

- (void)fetchBookCoverWithURL:(NSString*)urlStr completionBlock:(RemoteDataStoreFetchImageCompletionBlock)completionBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    NSURL *URL = [NSURL URLWithString:urlStr];

    NSURLRequest *request = [NSURLRequest requestWithURL:URL];

    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {

        NSURL *temporaryDirectoryURL = [NSURL fileURLWithPath:NSTemporaryDirectory() isDirectory:YES];
        return [temporaryDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];

    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {

        if(error != nil)
        {
            NSLog(@"Error: %@", error);
            return;
        }

        NSLog(@"File downloaded to: %@", filePath);

        if(completionBlock != nil)
        {
            completionBlock(filePath.path);
        }
    }];
    [downloadTask resume];
}

- (void)fetchOfferItemsForBookISBNs:(NSArray<NSString*> *)isbns completionBlock:(RemoteDataStoreFetchOfferItemsCompletionBlock)completionBlock
{
    NSString *urlStr = [NSString stringWithFormat:OffersURL, [isbns componentsJoinedByString:@","]];
    NSURL *URL = [NSURL URLWithString:urlStr];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);

        __block NSMutableArray<OfferItem*> *array = [NSMutableArray array];
        [responseObject[@"offers"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [array addObject:[self offerItemFromRemoteObject:obj]];
        }];

        if(completionBlock != nil)
        {
            completionBlock(array);
        }

    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        if(completionBlock != nil)
        {
            completionBlock(@[]);
        }

    }];
}

- (OfferItem*)offerItemFromRemoteObject:(NSDictionary*)dict
{
    OfferItem* offerItem = nil;

    switch ([self offerTypeForTypeString:dict[@"type"]]) {
        case Slice:
            offerItem = [SliceOfferItem sliceOfferItemWithValue:dict[@"value"] sliceValue:dict[@"sliceValue"]];
            break;
        case Minus:
            offerItem = [MinusOfferItem minusOfferItemWithValue:dict[@"value"]];
            break;
        case Percentage:
            offerItem = [PercentageOfferItem percentageOfferItemWithValue:dict[@"value"]];
            break;
        default:
            break;
    }

    return offerItem;
}

- (OfferType)offerTypeForTypeString:(NSString*)typeStr
{
    if([typeStr isEqualToString:@"slice"])
    {
        return Slice;
    }
    else if([typeStr isEqualToString:@"minus"])
    {
        return Minus;
    }
    else if([typeStr isEqualToString:@"percentage"])
    {
        return Percentage;
    }
    return Max;
}

@end
