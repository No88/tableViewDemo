//
//  LHBaseController.h
//  tableViewDemo
//
//  Created by liuhao on 17/3/28.
//  Copyright © 2017年 liuhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHBaseController : UITableViewController

@property (nonatomic, strong) void (^offSet)(CGFloat, UITableViewController *);

- (void)setTableViewOffSetY:(CGFloat)offSetY;

@end
