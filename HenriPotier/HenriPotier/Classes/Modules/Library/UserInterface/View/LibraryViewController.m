//
//  LibraryViewController.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "LibraryViewController.h"
#import "LibraryDisplayData.h"
#import "LibraryDisplayItem.h"
#import "LibraryItemViewCell.h"
#import "GoToCartButton.h"

static NSString* const LibraryCellIdentifier = @"LibraryCell";

@interface LibraryViewController () <UITableViewDataSource>
@property (nonatomic, strong)   LibraryDisplayData* data;
@property (nonatomic, assign)   int numberOfItemsInCart;
@property (nonatomic, strong)   IBOutlet UILabel* errorLabel;
@property (nonatomic, strong)   GoToCartButton *goToCartButton;
@end

@implementation LibraryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.goToCartButton = [[GoToCartButton alloc] initWithFrame:CGRectMake(0, 0, 45, 25)];

    [self refreshNavigationBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.eventHandler updateView];
}

- (void)refreshNavigationBar
{
    self.navigationItem.title = @"Bibliothèque";

    self.goToCartButton.number = self.numberOfItemsInCart;

    [self.goToCartButton addTarget:self action:@selector(didTapCartButton:) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *numberItem = [[UIBarButtonItem alloc] initWithCustomView:self.goToCartButton];
    self.navigationItem.rightBarButtonItem = numberItem;

    return;
}

- (void)didTapCartButton:(id)sender
{
    [self.eventHandler goToCart];
}

- (void)showNoContentMessageWithError:(NSString *)error
{
    self.tableView.hidden = YES;
    self.noContentView.hidden = NO;
    self.errorLabel.text = error;
}

- (void)showNumberOfItemsInCart:(int)numberOfItemsInCart
{
    self.numberOfItemsInCart = numberOfItemsInCart;
    [self refreshNavigationBar];
}

- (void)showLibraryDisplayData:(LibraryDisplayData *)data
{
    self.noContentView.hidden = YES;
    self.tableView.hidden = NO;
    self.data = data;
    [self reloadEntries];
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
    LibraryDisplayItem *item = self.data.items[indexPath.row];
    LibraryItemViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:LibraryCellIdentifier forIndexPath:indexPath];

    cell.tag = indexPath.row;
    cell.title = item.title;
    cell.price = item.price;
    cell.imageName = item.imageName;

    [cell addButtonTarget:self action:@selector(didTapOnAddToCartButton:)];

    return cell;
}

- (void)didTapOnAddToCartButton:(UIButton*)sender
{
    [self.eventHandler addToCartBookWithIsbn:self.data.items[sender.tag].isbn];
}

@end
