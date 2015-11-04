//
//  UIView+UIViewController.m
//  Daily
//
//  Created by mac on 15/10/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "UIView+UIViewController.h"

@implementation UIView (UIViewController)

-(UIViewController *)viewController {
    
    UIResponder *next = self.nextResponder;
    do {
        
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
    }while (next != nil) ;
    
    return nil;
    
    
    
}

@end
