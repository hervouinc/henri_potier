//
//  LibraryInteractorTests.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 27/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "LibraryInteractor.h"
#import "LibraryDataManager.h"
#import "BookItem.h"

@interface LibraryInteractorTests : XCTestCase
@property (nonatomic, strong)   LibraryInteractor*  interactor;
@property (nonatomic, strong)   id                  dataManager;
@property (nonatomic, strong)   id                  output;
@end

@implementation LibraryInteractorTests

- (void)setUp
{
    [super setUp];

    self.dataManager = [OCMockObject mockForClass:LibraryDataManager.class];
    self.interactor = [[LibraryInteractor alloc] initWithDataManager:self.dataManager];

    self.output = [OCMockObject mockForProtocol:@protocol(LibraryInteractorOutput)];
    self.interactor.output = self.output;
}

- (void)tearDown
{
    [self.dataManager verify];
    [self.output verify];

    [super tearDown];
}

- (void)testFindingBookItemsRequestsBookItems
{
    [[self.dataManager expect] bookItemsWithCompletionBlock:OCMOCK_ANY];

    [self.interactor findBookItems];
}

- (void)testFindingBookItemsWithNilBookItemsReturnsEmptyBookItems
{
    [self dataManagerWillReturnBookItems:nil error:nil];

    [self expectBookItems:@[]];

    [self.interactor findBookItems];
}

- (void)testFindingBookItemsWithEmptyBookItemsReturnsEmptyBookItems
{
    [self dataManagerWillReturnBookItems:@[] error:nil];

    [self expectBookItems:@[]];

    [self.interactor findBookItems];
}

- (void)testFindingBookItemsWithOneBookItemReturnsOneBookItemAndAskForOneCoverImage
{
    BookItem *bookItem = [BookItem bookItemWithTitle:@"Henry Potier et la chambre des tests" isbn:@"a460afed-e5e7-4e39-a39d-c885c05db861" price:@(38) coverURL:@"http://henri-potier.xebia.fr/hp1.jpg"];
    NSArray *bookItems = @[bookItem];

    [self dataManagerWillReturnBookItems:bookItems error:nil];

    [self expectBookItems:bookItems];
    [[self.dataManager expect] addCoverImageToBookItemWithIsbn:@"a460afed-e5e7-4e39-a39d-c885c05db861" completionBlock:OCMOCK_ANY];

    [self.interactor findBookItems];
}

- (void)testFindingBookItemsWithErrorReturnsError
{
    NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorNotConnectedToInternet userInfo:nil];
    [self dataManagerWillReturnBookItems:OCMOCK_ANY error:error];

    [[self.output expect] foundingBookItemsFailedWithError:error];

    [self.interactor findBookItems];
}

- (void)testAddingCoverImageRequestsCoverImage
{
    BookItem *bookItem = [BookItem bookItemWithTitle:@"Henry Potier et la chambre des tests" isbn:@"a460afed-e5e7-4e39-a39d-c885c05db861" price:@(38) coverURL:@"http://henri-potier.xebia.fr/hp1.jpg"];

    [[self.dataManager expect] addCoverImageToBookItemWithIsbn:OCMOCK_ANY completionBlock:OCMOCK_ANY];

    [self.interactor findCoverForBookItems:@[bookItem]];
}

- (void)testFindingCoverWithNoItemReturnedReturnsNothing
{
    BookItem *bookItem = [BookItem bookItemWithTitle:@"Henry Potier et la chambre des tests" isbn:@"a460afed-e5e7-4e39-a39d-c885c05db861" price:@(38) coverURL:@"http://wrongURL.com"];

    [[[self.dataManager stub] andDo:nil] addCoverImageToBookItemWithIsbn:OCMOCK_ANY completionBlock:OCMOCK_ANY];

    [[self.output reject] updatedBookItem:OCMOCK_ANY];

    [self.interactor findCoverForBookItems:@[bookItem]];
}

- (void)testFindingCoverForOneBookItemReturnsOneUpdatedBookItem
{
    BookItem *bookItem = [BookItem bookItemWithTitle:@"Henry Potier et la chambre des tests" isbn:@"a460afed-e5e7-4e39-a39d-c885c05db861" price:@(38) coverURL:@"http://henri-potier.xebia.fr/hp1.jpg"];

    BookItem *bookItemWithImage = [BookItem bookItemWithTitle:@"Henry Potier et la chambre des tests" isbn:@"a460afed-e5e7-4e39-a39d-c885c05db861" price:@(38) coverURL:@"http://henri-potier.xebia.fr/hp1.jpg"];
    bookItemWithImage.imageName = @"hp1.jpg";

    [self dataManagerWillReturnBookItem:bookItemWithImage];

    [[self.output expect] updatedBookItem:bookItemWithImage];

    [self.interactor findCoverForBookItems:@[bookItem]];
}

- (void)testAppReachabilityChangesToReachableAsksToFindItems
{
    [[self.dataManager expect] bookItemsWithCompletionBlock:OCMOCK_ANY];

    [self.interactor reachabilityDidChange:YES];
}

#pragma mark - Reusable code

- (void)dataManagerWillReturnBookItems:(NSArray *)bookItems error:(NSError*)error
{
    void (^doBlock)(NSInvocation *) =  ^(NSInvocation *invocation) {
        void (^completionBlock)(NSArray<BookItem*> *bookItems, NSError *error) = NULL;
        [invocation getArgument:&completionBlock atIndex:2];
        completionBlock(bookItems, error);
    };
    [[[self.dataManager stub] andDo:doBlock] bookItemsWithCompletionBlock:OCMOCK_ANY];
}

- (void)dataManagerWillReturnBookItem:(BookItem *)bookItem
{
    void (^doBlock)(NSInvocation *) =  ^(NSInvocation *invocation) {
        void (^completionBlock)(BookItem *bookItem) = NULL;
        [invocation getArgument:&completionBlock atIndex:3];
        completionBlock(bookItem);
    };
    [[[self.dataManager stub] andDo:doBlock] addCoverImageToBookItemWithIsbn:OCMOCK_ANY completionBlock:OCMOCK_ANY];
}

- (void)expectBookItems:(NSArray *)bookItems
{
    [[self.output expect] foundBookItems:bookItems];
}

@end
