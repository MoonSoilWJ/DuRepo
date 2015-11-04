//
//  NewsCell.m
//  Daily
//
//  Created by mac on 15/10/24.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "NewsCell.h"
#import "Common.h"
#import "DayNightManager.h"

@implementation NewsCell

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)awakeFromNib {

     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backcolorNatiAction) name:kthemeName object:nil];
   
    [self backcolorNatiAction];
}



-(void)backcolorNatiAction
{
    [UIView animateWithDuration:.3 animations:^{
        
        self.backgroundColor =[[DayNightManager shareInstance] getRightColor];
        
        self.titleLabel.textColor = [[DayNightManager shareInstance]getLabelColor];
    }];
}

-(void)setModel:(HomeModel *)model {
    if (_model != model) {
        _model = model;
        _titleLabel.text = _model.title;
        
        NSArray *images = (NSArray *)_model.images;
        [_headImage sd_setImageWithURL:[NSURL URLWithString:[images firstObject] ] placeholderImage:nil];
    }
}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
