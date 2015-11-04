//
//  ThemeColor.h
//  知乎日报
//
//  Created by MAC19 on 15/10/25.
//  Copyright (c) 2015年 MAC19. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Left.h"


@interface ThemeColorView : UIImageView

-(instancetype)initWithFrameRight:(CGRect)frame;
-(instancetype)initWithFrameLeft:(CGRect)frame;
-(instancetype)initWithFrameButton:(CGRect)frame;

@end
