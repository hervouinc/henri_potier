//
//  CartPresenterTests.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 28/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "CartPresenter.h"
#import "CartViewInterface.h"
#import "CartDisplayItem.h"
#import "CartDisplayData.h"
#import "CartModuleDelegateInterface.h"
#import "CartItem.h"
#import "PercentageOfferItem.h"

@interface CartPresenter (Testing)
- (float)totalPriceForCartItems:(NSArray<CartItem*>*)items;
- (int)totalItemCountInCartItems:(NSArray<CartItem*>*)items;
@end

@interface CartPresenterTests : XCTestCase
@property (nonatomic, strong)   CartPresenter*   presenter;
@property (nonatomic, strong)   id               ui;
@property (nonatomic, strong)   id               interactor;
@property (nonatomic, strong)   id               wireframe;
@property (nonatomic, strong)   id               delegate;
@end

@implementation CartPresenterTests

- (void)setUp
{
    [super setUp];

    self.presenter = [[CartPresenter alloc] init];
    self.ui = [OCMockObject mockForProtocol:@protocol(CartViewInterface)];
    self.interactor = [OCMockObject mockForProtocol:@protocol(CartInteractorInput)];
    self.delegate = [OCMockObject mockForProtocol:@protocol(CartModuleDelegateInterface)];

    self.presenter.userInterface = self.ui;
    self.presenter.cartInteractor = self.interactor;
    self.presenter.cartModuleDelegate = self.delegate;
}

- (void)tearDown
{
    [self.ui verify];
    [self.wireframe verify];

    [super tearDown];
}

- (void)testTotalPriceForCartItemsCountsWell
{
    BookItem *bookItem = [BookItem bookItemWithTitle:OCMOCK_ANY isbn:OCMOCK_ANY price:@(30) coverURL:OCMOCK_ANY];
    CartItem *cartItem = [CartItem cartItemWithBookItem:bookItem count:@(2)];
    BookItem *bookItem2 = [BookItem bookItemWithTitle:OCMOCK_ANY isbn:OCMOCK_ANY price:@(20) coverURL:OCMOCK_ANY];
    CartItem *cartItem2 = [CartItem cartItemWithBookItem:bookItem2 count:@(1)];

    float totalCalculated = [self.presenter totalPriceForCartItems:@[cartItem, cartItem2]];
    XCTAssertEqual(80, totalCalculated, @"count of total price is wrong");

    float zeroCalculated = [self.presenter totalPriceForCartItems:@[]];
    XCTAssertEqual(0, zeroCalculated, @"count of total price is wrong");
}

- (void)testTotalItemsCountForCartItemsCountsWell
{
    BookItem *bookItem = [BookItem bookItemWithTitle:OCMOCK_ANY isbn:OCMOCK_ANY price:@(30) coverURL:OCMOCK_ANY];
    CartItem *cartItem = [CartItem cartItemWithBookItem:bookItem count:@(2)];
    BookItem *bookItem2 = [BookItem bookItemWithTitle:OCMOCK_ANY isbn:OCMOCK_ANY price:@(20) coverURL:OCMOCK_ANY];
    CartItem *cartItem2 = [CartItem cartItemWithBookItem:bookItem2 count:@(1)];

    float totalCalculated = [self.presenter totalItemCountInCartItems:@[cartItem, cartItem2]];
    XCTAssertEqual(3, totalCalculated, @"count is wrong");

    float zeroCalculated = [self.presenter totalItemCountInCartItems:@[]];
    XCTAssertEqual(0, zeroCalculated, @"count is wrong");
}

- (void)testFoundZeroCartItemsDisplaysNoContentMessageAndPrice
{
    [[self.ui expect] showNoContentMessage];
    [[self.delegate expect] cartModuleDidUpdateCartItemsCount:0];
    [[self.ui expect] showTotalPrice:@"0.00 €"];
    [[self.ui expect] showOldTotalPrice:@""];

    [self.presenter foundCartItems:@[]];
}

- (void)testFoundOneCartItemDisplaysDisplayDataWithOneDisplayItemAndPrice
{
    BookItem *bookItem = [BookItem bookItemWithTitle:@"Henry Potier et la chambre des tests" isbn:@"a460afed-e5e7-4e39-a39d-c885c05db861" price:@(30) coverURL:@"http://henri-potier.xebia.fr/hp1.jpg"];
    bookItem.imageName = @"hp1.jpg";
    CartItem *cartItem = [CartItem cartItemWithBookItem:bookItem count:@(2)];

    CartDisplayItem *displayItem = [CartDisplayItem cartDisplayItemWithTitle:@"Henry Potier et la chambre des tests" isbn:@"a460afed-e5e7-4e39-a39d-c885c05db861" totalPrice:@"60.00 €" imageName:@"hp1.jpg" count:@(2)];
    CartDisplayData *displayData = [CartDisplayData cartDisplayDataWithItems:@[displayItem]];

    [[self.interactor expect] findBestOfferForCartItems:@[cartItem]];
    [[self.ui expect] showCartDisplayData:displayData];
    [[self.delegate expect] cartModuleDidUpdateCartItemsCount:2];
    [[self.ui expect] showTotalPrice:@"60.00 €"];
    [[self.ui expect] showOldTotalPrice:@""];

    [self.presenter foundCartItems:@[cartItem]];
}

- (void)testFoundNilBestOfferDisplaysNothing
{
    [[self.ui reject] showTotalPrice:OCMOCK_ANY];
    [[self.ui reject] showOldTotalPrice:OCMOCK_ANY];

    [self.presenter foundBestOffer:nil forCartItems:OCMOCK_ANY];
}

- (void)testFoundBestOfferForNilCartItemsDisplaysNothing
{
    [[self.ui reject] showTotalPrice:OCMOCK_ANY];
    [[self.ui reject] showOldTotalPrice:OCMOCK_ANY];

    [self.presenter foundBestOffer:OCMOCK_ANY forCartItems:nil];
}

- (void)testFoundBestOfferForCartItemsDisplaysPrice
{
    BookItem *bookItem = [BookItem bookItemWithTitle:@"Henry Potier et la chambre des tests" isbn:@"a460afed-e5e7-4e39-a39d-c885c05db861" price:@(30) coverURL:@"http://henri-potier.xebia.fr/hp1.jpg"];
    bookItem.imageName = @"hp1.jpg";
    CartItem *cartItem = [CartItem cartItemWithBookItem:bookItem count:@(2)];
    PercentageOfferItem *bestOfferItem = [PercentageOfferItem percentageOfferItemWithValue:@(20)]; // discount = 12

    [[self.ui expect] showTotalPrice:@"48.00 €"];
    [[self.ui expect] showOldTotalPrice:OCMOCK_ANY];

    [self.presenter foundBestOffer:bestOfferItem forCartItems:@[cartItem]];
}

- (void)testAddOneToCartAskInteratorToAddOneToCart
{
    NSString *isbn = @"a460afed-e5e7-4e39-a39d-c885c05db861";

    [[self.interactor expect] addOneToCartItemWithIsbn:isbn];

    [self.presenter didAddOneToCartItemWithIsbn:isbn];
}

- (void)testRemoveOneFromCartAskInteratorToRemoveOneFromCart
{
    NSString *isbn = @"a460afed-e5e7-4e39-a39d-c885c05db861";

    [[self.interactor expect] removeOneToCartItemWithIsbn:isbn];

    [self.presenter didRemoveOneToCartItemWithIsbn:isbn];
}

- (void)testLibraryModuleAskToAddToCartAsksInteractorToAddToCart
{
    NSString *isbn = @"a460afed-e5e7-4e39-a39d-c885c05db861";

    [[self.interactor expect] addToCartBookItemWithIsbn:isbn];

    [self.presenter libraryModuleAddToCartBookWithIsbn:isbn];
}

@end
