//
//  HenriPotierUITests.m
//  HenriPotierUITests
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface HenriPotierUITests : XCTestCase
@end

@implementation HenriPotierUITests

- (void)setUp
{
    [super setUp];

    self.continueAfterFailure = NO;

    [[[XCUIApplication alloc] init] launch];
}

- (void)tearDown
{
    [super tearDown];
}

@end
