//
//  MASExampleBasicMarginsView.m
//  Masonry iOS Examples
//
//  Created by DR on 15/10/2014.
//  Copyright (c) 2014 Jonas Budelmann. All rights reserved.
//

#import "MASExampleBasicMarginsView.h"

@interface MASExampleBasicMarginsView ()

@property (nonatomic) UIView *containerView;

@property (nonatomic) NSMutableDictionary *buttonsDictionary;

@end

@implementation MASExampleBasicMarginsView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.buttonsDictionary = [NSMutableDictionary dictionary];
    
    self.containerView = UIView.new;
    self.containerView.backgroundColor = [UIColor darkGrayColor];
    self.containerView.layoutMargins = UIEdgeInsetsMake(15, 15, 15, 15);
    [self addSubview:self.containerView];
    
    UIView *childView = UIView.new;
    childView.backgroundColor = [UIColor lightGrayColor];
    [self.containerView addSubview:childView];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.containerView.superview);
    }];

    [childView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.containerView).with.margins();
        
        // equivalent to:
//        make.top.equalTo(self.containerView.mas_topMargin);
//        make.left.equalTo(self.containerView.mas_leftMargin);
//        make.bottom.equalTo(self.containerView.mas_bottomMargin);
//        make.right.equalTo(self.containerView.mas_rightMargin);
    }];
    
    [self setupOffsetButtons];
    
    return self;
}

- (void)setupOffsetButtons {
    self.buttonsDictionary = [NSMutableDictionary dictionary];
    
    UIButton *button;
    
    button = [self setupButtonWithInsets:UIEdgeInsetsMake(0, 10, 0, 0) title:@"+"];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.centerY.equalTo(self).with.offset(-20);
    }];
    
    button = [self setupButtonWithInsets:UIEdgeInsetsMake(0, -10, 0, 0) title:@"-"];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.centerY.equalTo(self).with.offset(20);
    }];
    
    button = [self setupButtonWithInsets:UIEdgeInsetsMake(0, 0, 10, 0) title:@"+"];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).with.offset(-10);
        make.centerX.equalTo(self).with.offset(-20);
    }];
    
    button = [self setupButtonWithInsets:UIEdgeInsetsMake(0, 0, -10, 0) title:@"-"];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).with.offset(-10);
        make.centerX.equalTo(self).with.offset(20);
    }];
    
    button = [self setupButtonWithInsets:UIEdgeInsetsMake(0, 0, 0, 10) title:@"+"];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-10);
        make.centerY.equalTo(self).with.offset(-20);
    }];
    
    button = [self setupButtonWithInsets:UIEdgeInsetsMake(0, 0, 0, -10) title:@"-"];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-10);
        make.centerY.equalTo(self).with.offset(20);
    }];
    
    button = [self setupButtonWithInsets:UIEdgeInsetsMake(10, 0, 0, 0) title:@"+"];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(10);
        make.centerX.equalTo(self).with.offset(-20);
    }];
    
    button = [self setupButtonWithInsets:UIEdgeInsetsMake(-10, 0, 0, 0) title:@"-"];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(10);
        make.centerX.equalTo(self).with.offset(20);
    }];
}

- (UIButton *)setupButtonWithInsets:(UIEdgeInsets)insets title:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(adjustMargin:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    [self.buttonsDictionary addEntriesFromDictionary:@{ [NSValue valueWithNonretainedObject:button]:
                                                        [NSValue valueWithUIEdgeInsets:insets] }];
    
    return button;
}

- (void)adjustMargin:(UIButton *)sender {
    NSValue *value = self.buttonsDictionary[[NSValue valueWithNonretainedObject:sender]];
    
    UIEdgeInsets offsetInsets = value.UIEdgeInsetsValue;
    UIEdgeInsets marginInsets = self.containerView.layoutMargins;
    
    marginInsets.top += offsetInsets.top;
    marginInsets.left += offsetInsets.left;
    marginInsets.bottom += offsetInsets.bottom;
    marginInsets.right += offsetInsets.right;

    self.containerView.layoutMargins = marginInsets;
    
    NSLog(@"new margins %@", NSStringFromUIEdgeInsets(marginInsets));
}

@end
