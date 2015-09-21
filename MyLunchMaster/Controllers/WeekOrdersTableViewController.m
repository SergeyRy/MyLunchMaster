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
#import "JsonParserHelper.h"
#import "MealCell.h"

@interface WeekOrdersTableViewController ()
    @property (nonatomic, strong) AppData *appData;
    @property (nonatomic, strong) HttpApiHelper *httpClient;
    @property (nonatomic, strong) NSArray *daysOfWeek;
    @property (nonatomic, strong) UIBarButtonItem *changeEaterButton;
    @property (nonatomic, strong) JsonParserHelper *jsonParserHelper;

@end

@implementation WeekOrdersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initProperties];


    NSLog(@"table view did load");

    [[self httpClient] getOrdersForCurrentWeekSuccess:^(AFHTTPRequestOperation *task, id responseObject) {
                                            NSArray *eaters = [responseObject valueForKeyPath:@"eaters"];
                                            NSArray *orders = [responseObject valueForKeyPath:@"orders"];

                                            [self.appData setEaters:[self.jsonParserHelper parseEaters:eaters]];
                                            [self.appData setWeekOrders:[self.jsonParserHelper parseOrders:orders:self.appData.eaters]];

                                            [[self appData] setCurrentEater:self.appData.eaters[0]];

                                            [self.tableView reloadData];

                                            [self setChangeEaterButtonSettings];

                                            [[A0SimpleKeychain keychain] deleteEntryForKey:@"com.eatnow.lunchmaster.token"];
                                        }
                                       failure:^(AFHTTPRequestOperation *task, NSError *error) {
                                       }];
}

#pragma mark - init Properties

- (void)initProperties {
    [self setAppData:[AppData getInstance]];
    [self setHttpClient:[HttpApiHelper httpClient]];
    [self setJsonParserHelper:[JsonParserHelper getInstance]];

    [[self httpClient] setToken:[[A0SimpleKeychain keychain] stringForKey:@"com.eatnow.lunchmaster.token"]];
    [self setDaysOfWeek: @[@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday"]];

    self.changeEaterButton = [[UIBarButtonItem alloc] init];
}

- (void) setChangeEaterButtonSettings {
    self.changeEaterButton.target = self;
    self.changeEaterButton.action = @selector(openActionSheet);
    self.changeEaterButton.title = self.appData.currentEater.name;
    NSArray *actionButtonItems = @[self.changeEaterButton];
    self.parentViewController.navigationItem.rightBarButtonItems = actionButtonItems;
}

#pragma mark - Methods for Action Sheet

- (void) openActionSheet{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select current child please ..."
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:[self.appData.eaters[0] name], [self.appData.eaters[1] name], nil];
    [actionSheet showInView:self.view];

}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"Index = %d - Title = %@", buttonIndex, [actionSheet buttonTitleAtIndex:buttonIndex]);
    if (buttonIndex > [self.appData.eaters count] - 1) {
        return;
    }
    [self.appData setCurrentEater:self.appData.eaters[buttonIndex]];
    self.changeEaterButton.title = self.appData.currentEater.name;
    [self.tableView reloadData];


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
//    return self.daysOfWeek[section];
//}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //[tableView dequeueReusableHeaderFooterViewWithIdentifier:<#(NSString *)identifier#>]

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    NSString *string =[self.daysOfWeek objectAtIndex:section];
    /* Section header is in 0th index... */
    [label setText:string];
    [view addSubview:label];
    [view addSubview:label];

  //  [view setBackgroundColor:[UIColor colorWithRed:166/255.f green:177/255.f blue:186/255.f alpha:1.0]]; //your background color...
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSArray *val = self.appData.weekOrders[self.appData.currentEater];
    NSPredicate *theDayEquelSection = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return (section + 1) == ([[evaluatedObject dayOfWeekNumber] integerValue]);
    }];
    NSArray *filteredOrders = [val filteredArrayUsingPredicate:theDayEquelSection];

    return [filteredOrders count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    Order *orderForCurrentSection = [self.appData getOrderForEaterForCurrentEaterBySectionIndex:indexPath.section];

    MealCell *mealCell = (MealCell *)[tableView dequeueReusableCellWithIdentifier:@"MealCell"];
//    UIEdgeInsets inst = [UIEdgeInsets ]
    [mealCell.title setText: orderForCurrentSection.meal.title];
    [mealCell.descr setText: orderForCurrentSection.meal.descr];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    mealCell.separatorInset = UIEdgeInsetsZero;

    mealCell.mealImage.contentMode = UIViewContentModeScaleAspectFit;

    NSString *imageUrl= [NSString stringWithFormat:@"%@%@", BASE_URL, [orderForCurrentSection meal].imagePath];
    NSURL *url = [NSURL URLWithString:imageUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIImage *placeholderImage = [UIImage imageNamed:@"none"];

    __weak UITableViewCell *weakCell = mealCell;

    [mealCell.mealImage setImageWithURLRequest:request
                          placeholderImage:placeholderImage
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       weakCell.imageView.image = image;
                                       [weakCell setNeedsLayout];
                                   } failure: ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                        NSLog(@"%@", error);
                                   }];




//    static NSString *simpleTableIdentifier = @"MealCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];
//
//    Order *orderForCurrentSection = [self.appData getOrderForEaterForCurrentEaterBySectionIndex:indexPath.section];
//
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.textLabel.text = [orderForCurrentSection meal].title;
//    cell.detailTextLabel.text = [orderForCurrentSection meal].descr;
//
//    NSString *imageUrl= [NSString stringWithFormat:@"%@%@", BASE_URL, [orderForCurrentSection meal].imagePath];
//    NSURL *url = [NSURL URLWithString:imageUrl];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    UIImage *placeholderImage = [UIImage imageNamed:@"none"];
//
//    __weak UITableViewCell *weakCell = cell;
//
//    [cell.imageView setImageWithURLRequest:request
//                          placeholderImage:placeholderImage
//                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//                                       weakCell.imageView.image = image;
//                                       [weakCell setNeedsLayout];
//                                   } failure: ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//                                        NSLog(@"%@", error);
//                                   }];
    return mealCell;
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

        detailViewController.order = [self.appData getOrderForEaterForCurrentEaterBySectionIndex:indexPath.section];
    }
}

@end
