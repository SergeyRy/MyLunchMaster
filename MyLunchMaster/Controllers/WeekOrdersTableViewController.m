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
#import "Meal.h"
#import "Order.h"
#import "Constants.h"
#import "UIImageView+AFNetworking.h"
#import "MealDetailController.h"

@interface WeekOrdersTableViewController ()
    @property (nonatomic, strong) AppData *appData;
    @property (nonatomic, strong) HttpApiHelper *httpClient;
    @property (nonatomic, strong) NSArray *daysOfWeek;
@end

@implementation WeekOrdersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initProperties];


    NSLog(@"table view did load");

    [[self httpClient] getOrdersForCurrentWeekSuccess:^(AFHTTPRequestOperation *task, id responseObject) {
                                            NSArray *eaters = [responseObject valueForKeyPath:@"eaters"];
                                            NSArray *orders = [responseObject valueForKeyPath:@"orders"];

                                            [[self appData] setEaters:[self parceJsonEaters:eaters]];
                                            [[self appData] setWeekOrders:[self parseJsonOrders:orders]];
                                            [[self appData] setCurrentEater:self.appData.eaters[0]];
                                            [self.tableView reloadData];

                                            UIBarButtonItem *changeEaterButton = [[UIBarButtonItem alloc] init];
                                            changeEaterButton.target = self;
                                            changeEaterButton.action = @selector(openActionSheet);
                                            changeEaterButton.title = self.appData.currentEater.name;
                                            NSArray *actionButtonItems = @[changeEaterButton];
                                            self.parentViewController.navigationItem.rightBarButtonItems = actionButtonItems;

                                       }
                                       failure:^(AFHTTPRequestOperation *task, NSError *error) {
                                       }];
}

- (void) openActionSheet{

    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select current child please ..."
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:[self.appData.eaters[0] name], [self.appData.eaters[1] name], nil];

    [actionSheet showInView:self.view];

}

- (void) initProperties {
    [self setAppData:[AppData getInstance]];
    [self setHttpClient:[HttpApiHelper httpClient]];
    [[self httpClient] setToken:[[A0SimpleKeychain keychain] stringForKey:@"com.eatnow.lunchmaster.token"]];
    [self setDaysOfWeek: @[@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday"]];
}

#pragma mark - Methods for parse json response

- (NSMutableArray *) parceJsonEaters: (NSArray *) eaters {
    NSMutableArray *result = [[NSMutableArray alloc] init];

    for (NSDictionary *item in eaters) {
        Eater *eater = [[Eater alloc] initWithId:item[@"id"] andName:item[@"first_name"]];
        [result addObject:eater];
    }

    return result;
}

- (NSMutableDictionary *) parseJsonOrders: (NSMutableDictionary *) orders {
    NSMutableDictionary *weekOrders = [[NSMutableDictionary alloc] init];

    if ([[[self appData] eaters] count] > 0) {
        for (Eater *eater in [[self appData] eaters]) {
            NSMutableArray *eaterOrders = [[NSMutableArray alloc] init];

            for (NSDictionary *order in orders[[[eater id] stringValue]]) {

                NSString *orderId = order[@"order_id"];
                NSNumber *orderPrice = (NSNumber *)order[@"order_price"];
                NSString *allergens = order[@"allergens"];
                NSString *orderDate = order[@"meal_date"];

                NSString *mealId = order[@"meal_items"][@"id"];
                NSString *mealTitle = order[@"meal_items"][@"title"];
                NSString *mealDescription = order[@"meal_items"][@"description"];
                NSString *mealPictureUrl = order[@"meal_picture_url"];

                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"YYYY-MM-dd"];
                NSDate *dte = [dateFormat dateFromString:orderDate];

                [dateFormat setDateFormat:@"EEEE"]; // day, like "Saturday"
                NSString *dayOfWeekString = [dateFormat stringFromDate:dte];

                [dateFormat setDateFormat:@"c"]; // day number, like 7 for saturday
                NSNumber *dayOfWeekNumber = [dateFormat stringFromDate:dte];

                Meal *meal = [[Meal alloc] initWithId:mealId title:mealTitle descr:mealDescription allergens:allergens imagePath:mealPictureUrl];
                Order *order = [[Order alloc] initWithId:orderId date:orderDate dayOfWeekString:dayOfWeekString dayOfWeekNumber:dayOfWeekNumber price:orderPrice meal:meal];

                [eaterOrders addObject:order];
            }

            [weekOrders setObject:eaterOrders forKey:eater];
        }
    }

    return weekOrders;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [self.daysOfWeek count];
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return [self.daysOfWeek objectAtIndex:section];
//}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    NSString *string =[self.daysOfWeek objectAtIndex:section];
    /* Section header is in 0th index... */
    [label setText:string];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSArray *val = nil;
    NSArray *values = [[[self appData] weekOrders] allValues];

    if ([values count] != 0)
        val = (NSArray *)[values objectAtIndex:0];

    NSPredicate *theDayEquelSection = [NSPredicate predicateWithBlock:
            ^BOOL(id evaluatedObject, NSDictionary *bindings) {
                return (section + 1) == ([[evaluatedObject dayOfWeekNumber] integerValue]-1);
            }];
    NSArray *filteredOrders = [val filteredArrayUsingPredicate:theDayEquelSection];

    return [filteredOrders count];
    //return [self.test count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *val = nil;
    NSArray *values = [[[self appData] weekOrders] allValues];

    if ([values count] != 0)
        val = (NSArray *)[values objectAtIndex:0];

    static NSString *simpleTableIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [[val objectAtIndex:indexPath.section] meal].title;
    cell.detailTextLabel.text = [[val objectAtIndex:indexPath.section] meal].descr;

    NSString *imageUrl= [NSString stringWithFormat:@"%@%@", BASE_URL, [[val objectAtIndex:indexPath.section] meal].imagePath];
    NSURL *url = [NSURL URLWithString:imageUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIImage *placeholderImage = [UIImage imageNamed:@"none"];

    __weak UITableViewCell *weakCell = cell;

    [cell.imageView setImageWithURLRequest:request
                          placeholderImage:placeholderImage
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       weakCell.imageView.image = image;
                                       [weakCell setNeedsLayout];
                                   } failure: ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                        NSLog(@"%@", error);
                                   }];
    return cell;
}


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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"GoToMealDetails"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        MealDetailController *detailViewController = (MealDetailController *)segue.destinationViewController;

        NSArray *val = nil;
        NSArray *values = [[[self appData] weekOrders] allValues];

        if ([values count] != 0)
            val = (NSArray *)[values objectAtIndex:0];

        detailViewController.order = [val objectAtIndex:indexPath.section];
    }
}

@end
