//
//  CartViewController.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "CartViewController.h"
#import "CartDisplayData.h"
#import "CartDisplayItem.h"
#import "CartItemViewCell.h"

static NSString* const CartCellIdentifier = @"CartCell";

@interface CartViewController () <UITableViewDataSource>
@property (nonatomic, strong)   CartDisplayData* data;
@property (nonatomic, strong)   IBOutlet UIView* noContentView;
@property (nonatomic, strong)   IBOutlet UILabel* labelOldPrice;
@property (nonatomic, strong)   IBOutlet UILabel* labelPrice;
@property (nonatomic, strong)   IBOutlet UITableView* tableView;
@end

@implementation CartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.navigationItem.title = @"Panier";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.eventHandler updateView];
}

- (void)showNoContentMessage
{
    self.noContentView.hidden = NO;
    self.tableView.hidden = YES;
}

- (void)showCartDisplayData:(CartDisplayData *)data
{
    self.noContentView.hidden = YES;
    self.tableView.hidden = NO;
    self.data = data;
    [self reloadEntries];
}

- (void)showTotalPrice:(NSString*)totalPrice
{
    self.labelPrice.text = totalPrice;
}

- (void)showOldTotalPrice:(NSString*)oldTotalPrice
{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:oldTotalPrice];
    [attributeString addAttribute:NSStrikethroughStyleAttributeName
                            value:@2
                            range:NSMakeRange(0, [attributeString length])];
    self.labelOldPrice.attributedText = attributeString;
}

- (void)reloadEntries
{
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CartDisplayItem *item = self.data.items[indexPath.row];
    CartItemViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CartCellIdentifier forIndexPath:indexPath];

    cell.tag = indexPath.row;
    cell.title = item.title;
    cell.totalPrice = item.totalPrice;
    cell.imageName = item.imageName;
    cell.count = item.count;

    [cell addPlusButtonTarget:self action:@selector(didTapOnPlusButton:)];
    [cell addMinusButtonTarget:self action:@selector(didTapOnMinusButton:)];

    return cell;
}

- (void)didTapOnPlusButton:(UIButton*)sender
{
    CartDisplayItem *item = self.data.items[sender.tag];
    [self.eventHandler didAddOneToCartItemWithIsbn:item.isbn];
}

- (void)didTapOnMinusButton:(UIButton*)sender
{
    CartDisplayItem *item = self.data.items[sender.tag];
    [self.eventHandler didRemoveOneToCartItemWithIsbn:item.isbn];
}

@end
