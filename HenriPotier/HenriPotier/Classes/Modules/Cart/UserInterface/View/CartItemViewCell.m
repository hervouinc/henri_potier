//
//  CartItemViewCell.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 22/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "CartItemViewCell.h"

@interface CartItemViewCell ()

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *priceLabel;
@property (nonatomic, strong) IBOutlet UILabel *countLabel;
@property (nonatomic, strong) IBOutlet UIImageView *coverImageView;
@property (nonatomic, strong) IBOutlet UIButton *plusButton;
@property (nonatomic, strong) IBOutlet UIButton *minusButton;

@end

@implementation CartItemViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

- (void)setTotalPrice:(NSString *)totalPrice
{
    _totalPrice = totalPrice;
    self.priceLabel.text = totalPrice;
}

- (void)setCount:(NSNumber *)count
{
    _count = count;
    UIImage *image = count.intValue > 1 ? [UIImage imageNamed:@"Minus"] : [UIImage imageNamed:@"Trash"];
    [self.minusButton setBackgroundImage:image forState:UIControlStateNormal];
    self.countLabel.text = [NSString stringWithFormat:@"%d", self.count.intValue];
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;

    UIImage *img = nil;
    if(imageName)
    {
        NSURL *tmpDirURL = [NSURL fileURLWithPath:NSTemporaryDirectory() isDirectory:YES];
        NSURL *fileURL = [tmpDirURL URLByAppendingPathComponent:imageName];
        NSString* path = fileURL.path;
        img = [UIImage imageWithContentsOfFile:path];
    }
    self.coverImageView.image = img;
}

- (void)setTag:(NSInteger)tag
{
    [super setTag:tag];
    self.plusButton.tag = tag;
    self.minusButton.tag = tag;
}

- (void)addPlusButtonTarget:(id)target action:(SEL)action
{
    [self.plusButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)addMinusButtonTarget:(id)target action:(SEL)action
{
    [self.minusButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

@end
