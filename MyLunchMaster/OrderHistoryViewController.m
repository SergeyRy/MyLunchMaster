//
//  OrderHistoryViewController.m
//  MyLunchMaster
//
//  Created by Employee on 05.10.15.
//  Copyright (c) 2015 Employee. All rights reserved.
//

#import "OrderHistoryViewController.h"
#import "OrderHistoryService.h"
#import "OrderHistoryItem.h"

@interface OrderHistoryViewController ()

@property (nonatomic, strong) OrderHistoryService *orderHistoryService;

@end

@implementation OrderHistoryViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    //[self initFields];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self initFields];
    [self.tableView reloadData];

}

- (void)initFields {
    self.orderHistoryService = [[OrderHistoryService alloc] init];
    self.orderHistoryService.initData;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.orderHistoryService.orderHistoryItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"OrderHistoryItemCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];

    cell.textLabel.text = [self.orderHistoryService.orderHistoryItems[indexPath.row] orderDate];
    cell.detailTextLabel.text = [self.orderHistoryService.orderHistoryItems[indexPath.row] amount];
    return cell;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
