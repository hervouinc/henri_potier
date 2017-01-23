//
//  LibraryItemView.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "LibraryItemViewCell.h"

@interface LibraryItemViewCell ()

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *priceLabel;
@property (nonatomic, strong) IBOutlet UIImageView *coverImageView;
@property (nonatomic, strong) IBOutlet UIButton *addToCartButton;

@end

@implementation LibraryItemViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.addToCartButton.layer.cornerRadius = self.addToCartButton.bounds.size.height/2;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

- (void)setPrice:(NSString *)price
{
    _price = price;
    self.priceLabel.text = price;
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
    self.addToCartButton.tag = tag;
}

- (void)addButtonTarget:(id)target action:(SEL)action
{
    [self.addToCartButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

@end
