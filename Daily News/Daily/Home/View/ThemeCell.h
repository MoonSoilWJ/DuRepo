//
//  ThemeCell.h
//  Daily
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeModel.h"

#import "UIImageView+WebCache.h"

@interface ThemeCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *titleLabel0;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *headerImage;


@property (nonatomic, strong) ThemeModel *model;

@end
