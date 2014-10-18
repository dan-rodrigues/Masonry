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
    label.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque pretium libero nec sollicitudin fringilla. Donec iaculis, nibh ut malesuada porta, nunc enim laoreet arcu, sed commodo lectus lorem sed massa. Aenean ac felis in tortor dignissim pulvinar eget sit amet ligula. Ut nec congue sem. Morbi vel ante sit amet elit faucibus dapibus. Nulla ipsum purus, ultrices tempor erat vitae, eleifend placerat diam. Proin fermentum sollicitudin felis, et pretium ex auctor vitae. Pellentesque vestibulum, urna dignissim tincidunt convallis, libero nibh pharetra arcu, nec commodo elit neque venenatis dolor. Praesent eu tortor sem. Fusce non arcu vel tortor bibendum imperdiet vitae.";
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:20];
    label.numberOfLines = 0;
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
        make.top.bottom.leading.and.trailing.equalTo(label.superview).with.margins();
        
        // equivalent to:
//        make.leading.equalTo(label.superview.mas_leftMargin);
//        make.top.equalTo(label.superview.mas_topMargin);
    }];
    
    [self setupOffsetButtons];
    
    return self;
}

- (void)setupOffsetButtons {
    self.buttonsDictionary = [NSMutableDictionary dictionary];
    
    for (NSNumber *attribute in @[ @(MASAttributeTop), @(MASAttributeLeft),
                                   @(MASAttributeBottom), @(MASAttributeRight) ])
    {
        [self setupButtonWithDelta:10 forAttribute:attribute.integerValue];
        [self setupButtonWithDelta:-10 forAttribute:attribute.integerValue];
    }
}

- (UIButton *)setupButtonWithDelta:(CGFloat)delta forAttribute:(MASAttribute)attribute {
    BOOL deltaIsPositive = (delta > 0);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:(deltaIsPositive ? @"+" : @"-") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(adjustMargin:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    UIEdgeInsets insets;
    insets.top = (attribute == MASAttributeTop ? delta : 0);
    insets.left = (attribute == MASAttributeLeft ? delta : 0);
    insets.bottom = (attribute == MASAttributeBottom ? delta : 0);
    insets.right = (attribute == MASAttributeRight ? delta : 0);

    MASAttribute centerAttribute = MASAttributeCenterY;
    if (attribute == MASAttributeTop || attribute == MASAttributeBottom) {
        centerAttribute = MASAttributeCenterX;
    }
    
    [self.buttonsDictionary addEntriesFromDictionary:@{ [NSValue valueWithNonretainedObject:button]:
                                                        [NSValue valueWithUIEdgeInsets:insets] }];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        UIEdgeInsets insets = UIEdgeInsetsMake(10, 10, 10, 10);
        make.attributes(attribute).equalTo(self).with.insets(insets);
        make.attributes(centerAttribute).equalTo(self).with.offset(deltaIsPositive ? -20 : 20);
    }];
    
    return button;
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
    
    NSLog(@"new margins: %@", NSStringFromUIEdgeInsets(marginInsets));
}

@end
