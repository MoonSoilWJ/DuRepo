//
//  TouchView.m
//  知乎日报
//
//  Created by MAC19 on 15/10/25.
//  Copyright (c) 2015年 MAC19. All rights reserved.
//

#import "TouchView.h"

@implementation TouchView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIImageView *touchView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    touchView.image = [UIImage imageNamed:@"Field_Button_Highlight_Bg@2x"];
    
    UITouch *touch  = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    touchView.center = point;
    touchView.alpha = .3;
    
    [UIView  animateWithDuration:.3 animations:^{
        touchView.frame = CGRectMake(point.x-15, point.y-15, 30, 30);
    } completion:^(BOOL finished){
        touchView.hidden = YES;
    }];
    
    [self addSubview:touchView];
}


@end
