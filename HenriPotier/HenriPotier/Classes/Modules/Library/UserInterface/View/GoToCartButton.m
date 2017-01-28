//
//  GoToCartView.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 26/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "GoToCartButton.h"

@implementation GoToCartButton

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
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];

    UIImageView* iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    iv.image = [UIImage imageNamed:@"Cart"];
    iv.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:iv];

    if(self.number > 0)
    {
        float width = self.number > 99 ? 30 : 20;
        UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - width, 0, width, 20)];
        numberLabel.font = [UIFont systemFontOfSize:12];
        numberLabel.text = [NSString stringWithFormat:@"%d", self.number];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        numberLabel.textColor = [UIColor whiteColor];
        numberLabel.backgroundColor = [UIColor colorWithRed:230/255.f green:149/255.f blue:0.f alpha:1];
        numberLabel.layer.cornerRadius = numberLabel.frame.size.height/2;
        numberLabel.layer.masksToBounds = YES;

        [view addSubview:numberLabel];
    }

    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    [self setBackgroundImage:image forState:UIControlStateNormal];
}

@end
