//
//  GoToCartView.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 26/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "GoToCartView.h"

@implementation GoToCartView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self updateView];
}

- (void)setNumber:(int)number
{
    _number = number;
    [self updateView];
}

- (void)updateView
{
    UIImageView* iv = [[UIImageView alloc] initWithFrame:self.frame];
    iv.image = [UIImage imageNamed:@"Cart"];
    iv.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:iv];

    if(self.number > 0)
    {
        UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 20, 20)];
        numberLabel.font = [UIFont systemFontOfSize:12];
        numberLabel.text = [NSString stringWithFormat:@"%d", self.number];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        numberLabel.textColor = [UIColor whiteColor];
        numberLabel.backgroundColor = [UIColor colorWithRed:230/255.f green:149/255.f blue:0.f alpha:1];
        numberLabel.layer.cornerRadius = numberLabel.frame.size.height/2;
        numberLabel.layer.masksToBounds = YES;

        [self addSubview:numberLabel];
    }
}

@end
