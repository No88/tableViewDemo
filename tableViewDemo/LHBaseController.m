//
//  LHBaseController.m
//  tableViewDemo
//
//  Created by liuhao on 17/3/28.
//  Copyright © 2017年 liuhao. All rights reserved.
//

#import "LHBaseController.h"

@interface LHBaseController ()

@property (nonatomic, assign) NSInteger index;

@end

@implementation LHBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 244.0)];;
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(244, 0, 0, 0);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTableViewOffSetY:) name:@"kChangeTableViewOffSetYNotification" object:nil];
}

- (void)changeTableViewOffSetY:(NSNotification *)noti {
    NSInteger index = [noti.object integerValue];
    self.index = index;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.tableView.frame.origin.x / self.view.frame.size.width != self.index) {
        return;
    }
    !self.offSet ? : self.offSet(scrollView.contentOffset.y, self);
}

- (void)setTableViewOffSetY:(CGFloat)offSetY {
    if (self.tableView.contentOffset.y > 200 && offSetY > self.tableView.contentOffset.y) {
        return;
    }
    
    NSLog(@"%@", self);
    NSLog(@"%f", self.tableView.contentOffset.y);
    [self.tableView setContentOffset:CGPointMake(0, offSetY)];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
