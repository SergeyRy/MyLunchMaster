//
//  WeekOrdersTableViewController.m
//  MyLunchMaster
//
//  Created by Employee on 14.09.15.
//  Copyright (c) 2015 Employee. All rights reserved.
//

#import "WeekOrdersTableViewController.h"
#import "HttpApiHelper.h"
#import "SimpleKeychain.h"
#import "AppData.h"
#import "Eater.h"

@interface WeekOrdersTableViewController ()
    @property (nonatomic, strong) AppData *appData;
    @property (nonatomic, strong) HttpApiHelper *httpClient;
@end

@implementation WeekOrdersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    [self initProperties];

    NSLog(@"table view did load");

    //[[A0SimpleKeychain keychain] deleteEntryForKey:@"com.eatnow.lunchmaster.token"];

    [[self httpClient] getOrdersForCurrentWeekSuccess:^(AFHTTPRequestOperation *task, id responseObject) {
                                            NSArray *eaters = [responseObject valueForKeyPath:@"eaters"];
                                            NSArray *orders = [responseObject valueForKeyPath:@"orders"];

                                            [[self appData] setEaters:[self parceJsonEaters:eaters]];
                                       }
                                       failure:^(AFHTTPRequestOperation *task, NSError *error) {
                                       }];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) initProperties {
    [self setAppData:[AppData getInstance]];
    [self setHttpClient:[HttpApiHelper httpClient]];
    [[self httpClient] setToken:[[A0SimpleKeychain keychain] stringForKey:@"com.eatnow.lunchmaster.token"]];
}

- (NSMutableArray *) parceJsonEaters: (NSArray *) eaters {
    NSMutableArray *result = [[NSMutableArray alloc] init];

    for (NSDictionary *item in eaters) {
        Eater *eater = [[Eater alloc] initWithId:item[@"id"] andName:item[@"last_name"]];
        [result addObject:eater];
    }

    return result;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
