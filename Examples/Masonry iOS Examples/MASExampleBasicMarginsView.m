//
//  MASExampleBasicMarginsView.m
//  Masonry iOS Examples
//
//  Created by DR on 15/10/2014.
//  Copyright (c) 2014 Jonas Budelmann. All rights reserved.
//

#import "MASExampleBasicMarginsView.h"

@implementation MASExampleBasicMarginsView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    UIView *containerView = UIView.new;
    containerView.backgroundColor = [UIColor grayColor];
    [self addSubview:containerView];
    
    UIView *childView = UIView.new;
    childView.backgroundColor = [UIColor whiteColor];
    [containerView addSubview:childView];
    
    //...
    
    return self;
}

@end
