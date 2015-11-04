//
//  LeftTableViewCell.m
//  知乎日报
//
//  Created by MAC19 on 15/10/24.
//  Copyright (c) 2015年 MAC19. All rights reserved.
//

#import "LeftTableViewCell.h"
#import "ThemeColorView.h"
#import "UIViewExt.h"
@implementation LeftTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor =[UIColor clearColor];
    self.textLabel.textColor = [UIColor colorWithWhite:.5 alpha:1];
 
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(180, 0,60 , self.height);
    [ _button setImage:[UIImage imageNamed:@"Dark_Menu_Enter@2x"] forState:UIControlStateSelected];
        
    [ _button setImage:[UIImage imageNamed:@"Dark_Menu_Follow@2x"] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview: _button];
        
     
    }
    return self;
}

-(void)buttonAction:(UIButton *)button
{
    
    if (button.selected == NO) {
        if (_pointBlock) {
            _pointBlock();
        }
    }
    button.selected = YES;
}


-(void)addBlock:(PointBlock )block
{
    if (_pointBlock != block) {
        _pointBlock = block;
    }

}

-(void)setModel:(LeftModel *)model
{
    if(_model != model)
    {
        _model = model;
    }
    
    _name = model.name;
    self.textLabel.text =_name;
  
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
