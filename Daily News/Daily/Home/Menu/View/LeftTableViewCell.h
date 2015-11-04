//
//  LeftTableViewCell.h
//  知乎日报
//
//  Created by MAC19 on 15/10/24.
//  Copyright (c) 2015年 MAC19. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftModel.h"

typedef void(^PointBlock)(void);

@interface LeftTableViewCell : UITableViewCell

{
    PointBlock _pointBlock;
}

-(void)addBlock:(PointBlock )block;

@property(nonatomic,strong) UIButton *button;


@property(nonatomic,strong) LeftModel *model;
@property(nonatomic,strong) NSString *name;

@end
