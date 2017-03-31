//
//  LHTitlesView.m
//  tableViewDemo
//
//  Created by liuhao on 17/3/28.
//  Copyright © 2017年 liuhao. All rights reserved.
//

#import "LHTitlesView.h"

@interface LHTitlesView ()

@property (nonatomic, strong) NSArray *titles;
/** 所有按钮的数组 */
@property (nonatomic ,strong) NSMutableArray<UIButton *> *titleBtns;
// 记录上一个选中按钮
@property (nonatomic, weak) UIButton *selectButton;

@end

@implementation LHTitlesView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles {
    if (self = [super initWithFrame:frame]) {
        self.titles = titles;
        self.backgroundColor = [UIColor yellowColor];
        [self setupInit];
    }
    return self;
}

- (void)setCurrentTitleIndex:(NSInteger)index {
    [self selectTitleButton:self.titleBtns[index]];
}

- (void)titleClick:(UIButton *)button {
    // 0.获取角标
    NSInteger i = button.tag;
    
    !self.didTitleClick ? : self.didTitleClick(i);
    // 1.让标题按钮选中
    [self selectTitleButton:button];
}

- (void)selectTitleButton:(UIButton *)btn {
    // 恢复上一个按钮颜色
    [_selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    // 设置当前选中按钮的颜色
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    // 记录当前选中的按钮
    _selectButton = btn;
}

- (void)setupInit {
    CGFloat btnW = self.frame.size.width / self.titles.count;
    CGFloat btnH = self.frame.size.height;
    [self.titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = idx;
        btn.frame = (CGRect) {btnW * idx, 0, btnW, btnH};
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchDown];
        if (!idx) {
            [self titleClick:btn];
        }
        [self addSubview:btn];
        [self.titleBtns addObject:btn];
    }];
}

#pragma mark - 懒加载
- (NSMutableArray<UIButton *> *)titleBtns {
    if (!_titleBtns) {
        _titleBtns = [NSMutableArray array];
    }
    return _titleBtns;
}

@end
