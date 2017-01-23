//
//  LibraryService.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "LocalDataStore.h"
#import <CoreData/CoreData.h>
#import "CartItem.h"

static NSString* const DataBaseName = @"DataModel.sqlite";

@interface LocalDataStore ()
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@end

@implementation LocalDataStore

- (id)init
{
    self = [super init];
    if (!self) return nil;

    [self initializeCoreData];

    return self;
}

- (void)initializeCoreData
{
    NSManagedObjectModel *mom = [NSManagedObjectModel mergedModelFromBundles:nil];

    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];

    self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.managedObjectContext.persistentStoreCoordinator = psc;

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsURL = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [documentsURL URLByAppendingPathComponent:DataBaseName];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        NSError *error = nil;
        NSPersistentStoreCoordinator *psc = self.managedObjectContext.persistentStoreCoordinator;
        NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
        NSAssert(store != nil, @"Error initializing PSC: %@\n%@", error.localizedDescription, error.userInfo);
    });
}

- (void)fetchCartItemsWithCompletionBlock:(LocalDataStoreFetchItemsCompletionBlock)completionBlock
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"CartItem"];

    [self.managedObjectContext performBlock:^{
        NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:NULL];

        if (completionBlock)
        {
            __block NSMutableArray<CartItem*> *array = [NSMutableArray array];
            [results enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [array addObject:[self cartItemFromManagedObject:obj]];
            }];
            completionBlock(array);
        }
    }];
}

- (void)fetchCartItemWithIsbn:(NSString *)isbn completionBlock:(LocalDataStoreFetchItemCompletionBlock)completionBlock
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"CartItem"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"(isbn = %@)", isbn];

    [self.managedObjectContext performBlock:^{
        NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:NULL];

        if(results == nil || results.count < 1)
        {
            if (completionBlock)
            {
                completionBlock(nil);
            }
            return;
        }

        if (completionBlock)
        {
            NSManagedObject* managedObject = [results objectAtIndex:0];
            completionBlock([self cartItemFromManagedObject:managedObject]);
        }
    }];
}

- (void)addOneToCartItemWithIsbn:(NSString *)isbn completionBlock:(LocalDataStoreFetchItemCompletionBlock)completionBlock
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"CartItem"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"(isbn = %@)", isbn];

    [self.managedObjectContext performBlock:^{
        NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:NULL];

        if(results == nil || results.count < 1)
        {
            if (completionBlock)
            {
                completionBlock(nil);
            }
            return;
        }

        NSManagedObject* managedObject = [results objectAtIndex:0];
        NSNumber *count = [managedObject valueForKey:@"count"];
        [managedObject setValue:@(count.intValue + 1) forKey:@"count"];

        if (completionBlock)
        {
            completionBlock([self cartItemFromManagedObject:managedObject]);
        }
    }];
}

- (void)removeOneToCartItemWithIsbn:(NSString *)isbn completionBlock:(LocalDataStoreFetchItemCompletionBlock)completionBlock
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"CartItem"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"(isbn = %@)", isbn];

    [self.managedObjectContext performBlock:^{
        NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:NULL];

        if(results == nil || results.count < 1)
        {
            if (completionBlock)
            {
                completionBlock(nil);
            }
            return;
        }

        NSManagedObject* managedObject = [results objectAtIndex:0];
        NSNumber *count = [managedObject valueForKey:@"count"];
        [managedObject setValue:@(count.intValue - 1) forKey:@"count"];

        if (completionBlock)
        {
            completionBlock([self cartItemFromManagedObject:managedObject]);
        }
    }];
}

- (void)addCartItem:(CartItem *)cartItem
{
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:@"CartItem" inManagedObjectContext:[self managedObjectContext]];
    [managedObject setValue:cartItem.count forKey:@"count"];
    [managedObject setValue:cartItem.bookItem.title forKey:@"title"];
    [managedObject setValue:cartItem.bookItem.isbn forKey:@"isbn"];
    [managedObject setValue:cartItem.bookItem.price forKey:@"price"];
    [managedObject setValue:cartItem.bookItem.imageName forKey:@"imageName"];

    [self.managedObjectContext save:NULL];
}

- (void)removeCartItem:(CartItem *)cartItem
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"CartItem"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"(isbn = %@)", cartItem.bookItem.isbn];

    [self.managedObjectContext performBlock:^{
        NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:NULL];

        if(results == nil || results.count < 1)
        {
            return;
        }

        [results enumerateObjectsUsingBlock:^(NSManagedObject*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.managedObjectContext deleteObject:obj];
        }];

    }];
}


#pragma mark - Utils

- (CartItem*)cartItemFromManagedObject:(NSManagedObject*)managedObject
{
    return [CartItem cartItemWithBookItem:[BookItem bookItemWithTitle:[managedObject valueForKey:@"title"] isbn:[managedObject valueForKey:@"isbn"] price:[managedObject valueForKey:@"price"] imageName:[managedObject valueForKey:@"imageName"]] count:[managedObject valueForKey:@"count"]];

}

@end
