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
@property (nonatomic, strong) UIImageView *headImageView;

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
    [self.view addSubview:self.headImageView];
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

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default"]];
        _headImageView.frame = (CGRect){0, 0, SCREENW, 200};
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.clipsToBounds = YES;
    }
    return _headImageView;
}

- (NSArray *)childVCs {
    if (!_childVCs) {
        __weak ViewController *weakSelf = self;
        void(^offset)(CGFloat, UITableViewController *) = ^(CGFloat offsetY, UITableViewController *VC) {
            
            CGRect titleFrame = weakSelf.titleView.frame;
            
            titleFrame.origin.y = 200 - offsetY;
            if (titleFrame.origin.y <= 0) {
                titleFrame.origin.y = 0;
            }
//            else if (titleFrame.origin.y >= 200) {
//                titleFrame.origin.y = 200;
//            }
            
            weakSelf.titleView.frame = titleFrame;
            
            CGRect imageViewFrame = weakSelf.headImageView.frame;
            imageViewFrame.size.height = titleFrame.origin.y;
            weakSelf.headImageView.frame = imageViewFrame;
            
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
