//
//  ViewController.m
//  tableViewDemo
//
//  Created by liuhao on 17/3/28.
//  Copyright © 2017年 liuhao. All rights reserved.
//

#import "ViewController.h"
#import "LHHEHEController.h"
#import "LHHAHAController.h"
#import "LHHEIHEIController.h"

#import "LHTitlesView.h"
#import "LHPageView.h"



#define SCREENW [UIScreen mainScreen].bounds.size.width
#define SCREENH [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (nonatomic, strong) LHTitlesView *titleView;
@property (nonatomic, strong) LHPageView *pageView;
@property (nonatomic, strong) NSArray *childVCs;

@property (nonatomic, strong) UITableViewController *currentVC;
@property (nonatomic, assign) CGFloat oldOffsetY;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupInit];
}

- (void)setupInit {
    [self.view addSubview:self.pageView];
    [self.view addSubview:self.titleView];
    [self.pageView setCurrentIndex:0];
}

#pragma mark - lazy
- (LHTitlesView *)titleView {
    if (!_titleView) {
        _titleView = [[LHTitlesView alloc] initWithFrame:(CGRect){0, 200, SCREENW, 44} titles:@[@"哈哈", @"呵呵", @"嘿嘿"]];
        __weak ViewController *weakSelf = self;
        _titleView.didTitleClick = ^(NSInteger index) {
            [weakSelf.pageView setCurrentIndex:index];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kChangeTableViewOffSetYNotification" object:@(index)];
        };
    }
    return _titleView;
}

- (LHPageView *)pageView {
    if (!_pageView) {
        _pageView = [[LHPageView alloc] initWithFrame:self.view.bounds childVC:self.childVCs];
        __weak ViewController *weakSelf = self;
        _pageView.didEndScrollView = ^(NSInteger index) {
            [weakSelf.titleView setCurrentTitleIndex:index];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kChangeTableViewOffSetYNotification" object:@(index)];
        };
    }
    return _pageView;
}

- (NSArray *)childVCs {
    if (!_childVCs) {
        __weak ViewController *weakSelf = self;
        void(^offset)(CGFloat, UITableViewController *) = ^(CGFloat offsetY, UITableViewController *VC) {
            
            CGRect frame = weakSelf.titleView.frame;
            
            frame.origin.y = 200 - offsetY;
            if (frame.origin.y <= 0) {
                frame.origin.y = 0;
            } else if (frame.origin.y >= 200) {
                frame.origin.y = 200;
            }
            weakSelf.titleView.frame = frame;
            
            weakSelf.currentVC = VC;
            weakSelf.oldOffsetY = offsetY;
            [weakSelf.childVCs enumerateObjectsUsingBlock:^(LHBaseController *VC, NSUInteger idx, BOOL * _Nonnull stop) {
                if (![weakSelf.currentVC.description isEqualToString:VC.description]) {
                    [VC setTableViewOffSetY:offsetY];
                }
            }];
            NSLog(@"%f", offsetY);
        };
        
        LHHAHAController *haha = [LHHAHAController new];
        haha.offSet = offset;
        
        LHHEHEController *hehe = [LHHEHEController new];
        hehe.offSet = offset;
        
        LHHEIHEIController *heihei = [LHHEIHEIController new];
        heihei.offSet = offset;
        
        [self addChildViewController:haha];
        [self addChildViewController:hehe];
        [self addChildViewController:heihei];
        _childVCs = @[haha, hehe, heihei];
    }
    return _childVCs;
}

@end
