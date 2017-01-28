//
//  LibraryPresenterTests.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 27/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "LibraryPresenter.h"
#import "LibraryWireframe.h"
#import "LibraryViewInterface.h"
#import "LibraryDisplayItem.h"
#import "LibraryDisplayData.h"
#import "LibraryModuleDelegateInterface.h"
#import "BookItem.h"

@interface LibraryPresenterTests : XCTestCase
@property (nonatomic, strong)   LibraryPresenter*   presenter;
@property (nonatomic, strong)   id                  ui;
@property (nonatomic, strong)   id                  wireframe;
@property (nonatomic, strong)   id                  delegate;
@end

@implementation LibraryPresenterTests

- (void)setUp
{
    [super setUp];

    self.presenter = [[LibraryPresenter alloc] init];
    self.ui = [OCMockObject mockForProtocol:@protocol(LibraryViewInterface)];
    self.wireframe = [OCMockObject mockForClass:LibraryWireframe.class];
    self.delegate = [OCMockObject mockForProtocol:@protocol(LibraryModuleDelegateInterface)];

    self.presenter.userInterface = self.ui;
    self.presenter.libraryWireframe = self.wireframe;
    self.presenter.libraryModuleDelegate = self.delegate;
}

- (void)tearDown
{
    [self.ui verify];
    [self.wireframe verify];

    [super tearDown];
}

- (void)testFoundZeroBookItemsDisplaysNoContentMessageWithNilError
{
    [[self.ui expect] showNoContentMessageWithError:nil];

    [self.presenter foundBookItems:@[]];
}

- (void)testFoundOneBookItemDisplaysDisplayDataWithOneDisplayItem
{
    BookItem *bookItem = [BookItem bookItemWithTitle:@"Henry Potier et la chambre des tests" isbn:@"a460afed-e5e7-4e39-a39d-c885c05db861" price:@(38) coverURL:@"http://henri-potier.xebia.fr/hp1.jpg"];
    bookItem.imageName = @"hp1.jpg";

    LibraryDisplayItem *displayItem = [LibraryDisplayItem libraryDisplayItemWithTitle:@"Henry Potier et la chambre des tests" isbn:@"a460afed-e5e7-4e39-a39d-c885c05db861" price:@"38.00 €" imageName:@"hp1.jpg"];
    LibraryDisplayData *displayData = [LibraryDisplayData libraryDisplayDataWithItems:@[displayItem]];

    [[self.ui expect] showLibraryDisplayData:displayData];

    [self.presenter foundBookItems:@[bookItem]];
}

- (void)testFoundNotConnectedErrorDisplaysNoContentMessageWithNotConnectedErrorMessage
{
    NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorNotConnectedToInternet userInfo:nil];

    [[self.ui expect] showNoContentMessageWithError:@"Verifiez votre connection internet."];

    [self.presenter foundingBookItemsFailedWithError:error];
}

- (void)testCartModuleDidUpdateCartItemsCountDisplaysNumberOfItemsInCart
{
    int count = 3;

    [[self.ui expect] showNumberOfItemsInCart:count];

    [self.presenter cartModuleDidUpdateCartItemsCount:count];
}

- (void)testGoToCartPresentsCartUI
{
    [[self.wireframe expect] presentCartInterface];

    [self.presenter goToCart];
}

- (void)testAddToCartAskModuleDelegateToAddToCart
{
    NSString *isbn = @"a460afed-e5e7-4e39-a39d-c885c05db861";

    [[self.delegate expect] libraryModuleAddToCartBookWithIsbn:isbn];

    [self.presenter addToCartBookWithIsbn:isbn];
}

- (void)testCartModuleDidUpdateCartItemsCountDisplaysCartItemsCount
{
    int count = 2;

    [[self.ui expect] showNumberOfItemsInCart:count];

    [self.presenter cartModuleDidUpdateCartItemsCount:count];
}

@end
