//
//  ThemeCell.m
//  Daily
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "ThemeCell.h"
#import "DayNightManager.h"

@implementation ThemeCell

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)awakeFromNib {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backcolorNatiAction) name:kthemeName object:nil];
    
    [self backcolorNatiAction];

}

//更改主题时，主题的变化
-(void)backcolorNatiAction
{
    
    [UIView animateWithDuration:.3 animations:^{
        
        self.backgroundColor =[[DayNightManager shareInstance] getRightColor];
        
        self.titleLabel.textColor = [[DayNightManager shareInstance]getLabelColor];
        self.titleLabel0.textColor = [[DayNightManager shareInstance]getLabelColor];
    }];
}

-(void)setModel:(ThemeModel *)model {
    
    if (_model != model) {
        _model = model;
        
        _titleLabel.text = _model.title;
        _titleLabel0.text = _model.title;
        
        if (_model.images.count > 0) {
            [_headerImage sd_setImageWithURL:[NSURL URLWithString:_model.images[0]]];
            
        }
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
