//
//  CartInteractorTests.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 28/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "CartInteractor.h"
#import "CartDataManager.h"
#import "CartItem.h"
#import "PercentageOfferItem.h"
#import "MinusOfferItem.h"
#import "SliceOfferItem.h"

@interface CartInteractorTests : XCTestCase
@property (nonatomic, strong)   CartInteractor*  interactor;
@property (nonatomic, strong)   id               dataManager;
@property (nonatomic, strong)   id               output;

@end

@implementation CartInteractorTests

- (void)setUp
{
    [super setUp];

    self.dataManager = [OCMockObject mockForClass:CartDataManager.class];
    self.interactor = [[CartInteractor alloc] initWithDataManager:self.dataManager];

    self.output = [OCMockObject mockForProtocol:@protocol(CartInteractorOutput)];
    self.interactor.output = self.output;
}

- (void)tearDown
{
    [self.dataManager verify];
    [self.output verify];

    [super tearDown];
}

- (void)testFindingCartItemsRequestsCartItems
{
    [[self.dataManager expect] cartItemsWithCompletionBlock:OCMOCK_ANY];

    [self.interactor findCartItems];
}

- (void)testFindingCartItemsWithNilCartItemsReturnsEmptyCartItems
{
    [self dataManagerWillReturnCartItems:nil];

    [self expectCartItems:@[]];

    [self.interactor findCartItems];
}

- (void)testFindingBookItemsWithEmptyCartItemsReturnsEmptyCartItems
{
    [self dataManagerWillReturnCartItems:@[]];

    [self expectCartItems:@[]];

    [self.interactor findCartItems];
}

- (void)testFindingCartItemsWithOneCartItemReturnsOneCartItem
{
    BookItem *bookItem = [BookItem bookItemWithTitle:@"Henry Potier et la chambre des tests" isbn:@"a460afed-e5e7-4e39-a39d-c885c05db861" price:@(38) coverURL:@"http://henri-potier.xebia.fr/hp1.jpg"];
    bookItem.imageName = @"hp1.jpg";
    CartItem *cartItem = [CartItem cartItemWithBookItem:bookItem count:@(3)];
    NSArray *cartItems = @[cartItem];

    [self dataManagerWillReturnCartItems:cartItems];

    [self expectCartItems:cartItems];

    [self.interactor findCartItems];
}

- (void)testFindingBestOfferRequestsBestOffer
{
    NSArray *isbns = @[@"a460afed-e5e7-4e39-a39d-c885c05db861"];
    BookItem *bookItem = [BookItem bookItemWithTitle:@"Henry Potier et la chambre des tests" isbn:@"a460afed-e5e7-4e39-a39d-c885c05db861" price:@(38) coverURL:@"http://henri-potier.xebia.fr/hp1.jpg"];
    bookItem.imageName = @"hp1.jpg";
    CartItem *cartItem = [CartItem cartItemWithBookItem:bookItem count:@(3)];
    NSArray *cartItems = @[cartItem];

    [[self.dataManager expect] offerItemsWithIsbns:isbns completionBlock:OCMOCK_ANY];

    [self.interactor findBestOfferForCartItems:cartItems];
}

- (void)testFindingBestOfferWithNilOfferItemsReturnsNothing
{
    [self dataManagerWillReturnOfferItems:nil];

    [[self.output reject] foundBestOffer:OCMOCK_ANY forCartItems:OCMOCK_ANY];

    [self.interactor findBestOfferForCartItems:nil];
}

- (void)testFindingBestOfferWithEmptyOfferItemsReturnsNothing
{
    [self dataManagerWillReturnOfferItems:@[]];

    [[self.output reject] foundBestOffer:OCMOCK_ANY forCartItems:OCMOCK_ANY];

    [self.interactor findBestOfferForCartItems:@[]];
}

- (void)testFindingBestOfferWithOneOfferItemReturnsOneOfferItem
{
    BookItem *bookItem = [BookItem bookItemWithTitle:@"Henry Potier et la chambre des tests" isbn:@"a460afed-e5e7-4e39-a39d-c885c05db861" price:@(38) coverURL:@"http://henri-potier.xebia.fr/hp1.jpg"];
    bookItem.imageName = @"hp1.jpg";
    CartItem *cartItem = [CartItem cartItemWithBookItem:bookItem count:@(3)];

    PercentageOfferItem *offerItem = [PercentageOfferItem percentageOfferItemWithValue:@(20)];

    [self dataManagerWillReturnOfferItems:@[offerItem]];

    [[self.output expect] foundBestOffer:offerItem forCartItems:@[cartItem]];

    [self.interactor findBestOfferForCartItems:@[cartItem]];
}

- (void)testFindingBestOfferWithOfferItemsReturnsBestOfferItem
{
    BookItem *bookItem = [BookItem bookItemWithTitle:@"Henry Potier et la chambre des tests" isbn:@"a460afed-e5e7-4e39-a39d-c885c05db861" price:@(30) coverURL:@"http://henri-potier.xebia.fr/hp1.jpg"];
    bookItem.imageName = @"hp1.jpg";
    CartItem *cartItem = [CartItem cartItemWithBookItem:bookItem count:@(4)];  // total price = 120

    PercentageOfferItem *bestOfferItem = [PercentageOfferItem percentageOfferItemWithValue:@(20)]; // discount = 24
    SliceOfferItem *offerItem2 = [SliceOfferItem sliceOfferItemWithValue:@(15) sliceValue:@(100)]; // discount = 15
    MinusOfferItem *offerItem3 = [MinusOfferItem minusOfferItemWithValue:@(20)]; // discount = 20

    [self dataManagerWillReturnOfferItems:@[bestOfferItem, offerItem2, offerItem3]];

    [[self.output expect] foundBestOffer:bestOfferItem forCartItems:@[cartItem]];

    [self.interactor findBestOfferForCartItems:@[cartItem]];
}

#pragma mark - Reusable code

- (void)dataManagerWillReturnCartItems:(NSArray *)cartItems
{
    void (^doBlock)(NSInvocation *) =  ^(NSInvocation *invocation) {
        void (^completionBlock)(NSArray<CartItem*> *cartItems) = NULL;
        [invocation getArgument:&completionBlock atIndex:2];
        completionBlock(cartItems);
    };
    [[[self.dataManager stub] andDo:doBlock] cartItemsWithCompletionBlock:OCMOCK_ANY];
}

- (void)expectCartItems:(NSArray *)cartItems
{
    [[self.output expect] foundCartItems:cartItems];
}

- (void)dataManagerWillReturnOfferItems:(NSArray *)offerItems
{
    void (^doBlock)(NSInvocation *) =  ^(NSInvocation *invocation) {
        void (^completionBlock)(NSArray<OfferItem*> *offerItems) = NULL;
        [invocation getArgument:&completionBlock atIndex:3];
        completionBlock(offerItems);
    };
    [[[self.dataManager stub] andDo:doBlock] offerItemsWithIsbns:OCMOCK_ANY completionBlock:OCMOCK_ANY];
}

@end
