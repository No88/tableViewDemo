//
//  LHHAHAController.m
//  tableViewDemo
//
//  Created by liuhao on 17/3/28.
//  Copyright © 2017年 liuhao. All rights reserved.
//

#import "LHHAHAController.h"

@interface LHHAHAController ()

@end

@implementation LHHAHAController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSString *)description {
    return @"haha";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}

@end
