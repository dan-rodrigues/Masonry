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
    childView.layoutMargins = UIEdgeInsetsMake(40, 40, 40, 40);
    [self.containerView addSubview:childView];
    
    UILabel *label = UILabel.new;
    label.text = @"Sample Text";
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:20];
    [childView addSubview:label];
    
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
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(label.superview).with.margins();
        
        // equivalent to:
//        make.leading.equalTo(label.superview.mas_leftMargin);
//        make.top.equalTo(label.superview.mas_topMargin);
    }];
    
    [self setupOffsetButtons];
    
    return self;
}

- (void)setupOffsetButtons {
    self.buttonsDictionary = [NSMutableDictionary dictionary];
    
    UIButton *button;
    
    button = [self setupButtonWithDeltaInsets:UIEdgeInsetsMake(0, 10, 0, 0) title:@"+"];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.centerY.equalTo(self).with.offset(-20);
    }];
    
    button = [self setupButtonWithDeltaInsets:UIEdgeInsetsMake(0, -10, 0, 0) title:@"-"];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.centerY.equalTo(self).with.offset(20);
    }];
    
    button = [self setupButtonWithDeltaInsets:UIEdgeInsetsMake(0, 0, 10, 0) title:@"+"];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).with.offset(-10);
        make.centerX.equalTo(self).with.offset(-20);
    }];
    
    button = [self setupButtonWithDeltaInsets:UIEdgeInsetsMake(0, 0, -10, 0) title:@"-"];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).with.offset(-10);
        make.centerX.equalTo(self).with.offset(20);
    }];
    
    button = [self setupButtonWithDeltaInsets:UIEdgeInsetsMake(0, 0, 0, 10) title:@"+"];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-10);
        make.centerY.equalTo(self).with.offset(-20);
    }];
    
    button = [self setupButtonWithDeltaInsets:UIEdgeInsetsMake(0, 0, 0, -10) title:@"-"];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-10);
        make.centerY.equalTo(self).with.offset(20);
    }];
    
    button = [self setupButtonWithDeltaInsets:UIEdgeInsetsMake(10, 0, 0, 0) title:@"+"];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(10);
        make.centerX.equalTo(self).with.offset(-20);
    }];
    
    button = [self setupButtonWithDeltaInsets:UIEdgeInsetsMake(-10, 0, 0, 0) title:@"-"];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(10);
        make.centerX.equalTo(self).with.offset(20);
    }];
}

- (UIButton *)setupButtonWithDeltaInsets:(UIEdgeInsets)insets title:(NSString *)title {
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
