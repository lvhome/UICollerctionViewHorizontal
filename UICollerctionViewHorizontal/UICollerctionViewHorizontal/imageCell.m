//
//  imageCell.m
//  UICollerctionViewHorizontal
//
//  Created by MAC on 2018/11/8.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "imageCell.h"
// 屏幕比例
#define SCREEN_RATE       ([UIScreen mainScreen].bounds.size.width/375.0)

@interface imageCell()
@property (nonatomic, strong) UIImageView *itemIcon;
@end

@implementation imageCell

@synthesize itemModel = _itemModel;

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self initView];
    }
    return self;
}

- (void)initView{
    _itemIcon = [[UIImageView alloc] init];
    [self.contentView addSubview:_itemIcon];
    _itemIcon.backgroundColor = [UIColor clearColor];
    CGFloat iconWidth = 80 * SCREEN_RATE;
    _itemIcon.frame = CGRectMake(0, 0, iconWidth, iconWidth);
    _itemIcon.center = self.contentView.center;
}

- (CollModel *)itemModel{
    return _itemModel;
}

- (void)setItemModel:(CollModel *)itemModel
{
    if (!itemModel) {
        return;
    }
    _itemModel = itemModel;
    
    [self setCellWithModel:_itemModel];
}

- (void)setCellWithModel:(CollModel *)itemModel{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        _itemIcon.image = [UIImage imageNamed:itemModel.url];
    }];
}






@end
