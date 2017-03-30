//
//  LHPageView.h
//  tableViewDemo
//
//  Created by liuhao on 17/3/28.
//  Copyright © 2017年 liuhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHPageView : UIView

@property (nonatomic, strong) void(^didEndScrollView)(NSInteger);

- (instancetype)initWithFrame:(CGRect)frame childVC:(NSArray *)childVC;

- (void)setCurrentIndex:(NSInteger)index;

@end
