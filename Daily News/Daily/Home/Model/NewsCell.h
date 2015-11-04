//
//  NewsCell.h
//  Daily
//
//  Created by mac on 15/10/24.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
#import "ThemeLabel.h"
#import "ThemeColorView.h"

@interface NewsCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *headImage;

@property (nonatomic, strong) HomeModel *model;

@end
