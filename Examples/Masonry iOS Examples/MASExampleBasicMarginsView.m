//
//  MASExampleBasicMarginsView.m
//  Masonry iOS Examples
//
//  Created by DR on 15/10/2014.
//  Copyright (c) 2014 Jonas Budelmann. All rights reserved.
//

#import "MASExampleBasicMarginsView.h"

@interface MASExampleBasicMarginsView ()

@property (nonatomic) UIButton *leftIncreaseButton;

@property (nonatomic) UIView *containerView;

@end

@implementation MASExampleBasicMarginsView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.containerView = UIView.new;
    self.containerView.backgroundColor = [UIColor darkGrayColor];
    //TODO: interactive updating of these margins. 4 buttons positioned around the center maybe
    self.containerView.layoutMargins = UIEdgeInsetsMake(12, 24, 48, 96);
    [self addSubview:self.containerView];
    
    UIView *childView = UIView.new;
    childView.backgroundColor = [UIColor lightGrayColor];
    [self.containerView addSubview:childView];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.containerView.superview);
    }];

    //TODO: some shorthand way of saying .constraintedToMargins(?)
    [childView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerView.mas_topMargin);
        make.left.equalTo(self.containerView.mas_leftMargin);
        make.bottom.equalTo(self.containerView.mas_bottomMargin);
        make.right.equalTo(self.containerView.mas_rightMargin);
    }];
    
    // setting the margin constraint directly seems wrong, but it's really setting the view's frame *relative* to the margin point (TODO: investigate)
    
    // adjustment buttons
    UIButton *leftIncreaseButton = [UIButton buttonWithType:UIButtonTypeSystem];
    leftIncreaseButton.backgroundColor = [UIColor whiteColor];
    [leftIncreaseButton setTitle:@"+" forState:UIControlStateNormal];
    [leftIncreaseButton addTarget:self action:@selector(adjustMargin:) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:leftIncreaseButton];
    
    // TODO: remainder of buttons...
    
    [leftIncreaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //-16 required to make it sit flush despite inset margin of 8
        //this yeilds frame XY = 8, -4
        //NOTE: this is tied to the top inset of 12 for containerView layoutMargins
        //investigate how to cancel this effect
        make.topMargin.equalTo(@8);
        make.leftMargin.equalTo(@8);
        
//        make.left.equalTo(self.containerView).with.offset(10);
//        make.centerY.equalTo(self.containerView);
    }];

    
    leftIncreaseButton.layoutMargins = UIEdgeInsetsMake(8, 8, 8, 8);
    
    self.leftIncreaseButton = leftIncreaseButton;
    
    return self;
}

- (void)adjustMargin:(UIButton *)sender {
    UIEdgeInsets insets = self.containerView.layoutMargins;
    insets.left += 10.0;
    self.containerView.layoutMargins = insets;
}

@end
