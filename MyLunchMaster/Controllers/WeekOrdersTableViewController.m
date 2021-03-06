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
#import "EmptyCell.h"
#import <QuartzCore/QuartzCore.h>
#import "MealListViewController.h"
#import "MealDetailController.h"


typedef NS_ENUM(NSInteger, TypeCell) {
    WithOrder,
    WithOutOrder
};


@interface WeekOrdersTableViewController ()

@property (nonatomic, strong) AppData *appData;
@property (nonatomic, strong) HttpApiHelper *httpClient;
@property (nonatomic, strong) NSArray *daysOfWeek;
@property (nonatomic, strong) NSArray *datesOfWeek;
@property (nonatomic, strong) UIBarButtonItem *changeEaterButton;
@property (nonatomic, strong) JsonParserHelper *jsonParserHelper;


@end

@implementation WeekOrdersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initProperties];

    UIImageView *navigationImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 130, 15)];
    navigationImage.image=[UIImage imageNamed:@"Logo"];
    UIImageView *workaroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 130, 15)];
    [workaroundImageView addSubview:navigationImage];
    self.navigationItem.titleView=workaroundImageView;

    NSLog(@"table view did load");
    

    [[self httpClient] getOrdersForCurrentWeekSuccess:^(AFHTTPRequestOperation *task, id responseObject) {
                                            NSArray *eaters = [responseObject valueForKeyPath:@"eaters"];
                                            NSArray *orders = [responseObject valueForKeyPath:@"orders"];

                                            [self.appData setEaters:[self.jsonParserHelper parseEaters:eaters]];
                                            [self.appData setWeekOrders:[self.jsonParserHelper parseOrders:orders:self.appData.eaters]];

                                            [[self appData] setCurrentEater:self.appData.eaters[0]];

                                            [self.tableView reloadData];

                                            [self setChangeEaterButtonSettings];

                                            //[[A0SimpleKeychain keychain] deleteEntryForKey:@"com.eatnow.lunchmaster.token"];


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
    [self fillDatesOfWeek];

    self.changeEaterButton = [[UIBarButtonItem alloc] init];
}

- (void)fillDatesOfWeek {
    NSDate *weekDate = [NSDate date];
    NSCalendar *myCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];

    NSDateComponents *currentComps = [myCalendar components:( NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekOfYearCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:weekDate];
    
    [currentComps setWeekday:2]; // 2: monday
    NSDate *firstDayOfTheWeek = [myCalendar dateFromComponents:currentComps];
    [currentComps setWeekday:3];
    NSDate *secondDayOfTheWeek = [myCalendar dateFromComponents:currentComps];
    [currentComps setWeekday:4];
    NSDate *therdDayOfTheWeek = [myCalendar dateFromComponents:currentComps];
    [currentComps setWeekday:5];
    NSDate *fourthDayOfTheWeek = [myCalendar dateFromComponents:currentComps];
    [currentComps setWeekday:6];
    NSDate *fifthDayOfTheWeek = [myCalendar dateFromComponents:currentComps];

    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
//    myDateFormatter.dateFormat = @"EEEE (dd MMM YYYY)";
    myDateFormatter.dateFormat = @"YYYY-MM-dd";
    [self setDatesOfWeek:@[
            [myDateFormatter stringFromDate:firstDayOfTheWeek],
            [myDateFormatter stringFromDate:secondDayOfTheWeek],
            [myDateFormatter stringFromDate:therdDayOfTheWeek],
            [myDateFormatter stringFromDate:fourthDayOfTheWeek],
            [myDateFormatter stringFromDate:fifthDayOfTheWeek]
    ]];
}

- (void) setChangeEaterButtonSettings {
    self.changeEaterButton.target = self;
    self.changeEaterButton.action = @selector(openActionSheet);
    self.changeEaterButton.title = self.appData.currentEater.name;
    NSArray *actionButtonItems = @[self.changeEaterButton];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
}

#pragma mark - Methods for Action Sheet

- (void)openActionSheet{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select current child please ..."
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:[self.appData.eaters[0] name], [self.appData.eaters[1] name], nil];
    [actionSheet showInView:self.view];

}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
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


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];

    UILabel *lblDate = [[UILabel alloc] initWithFrame:CGRectMake(view.bounds.size.width/2 - 40, 5, 200, 18)];
    [lblDate setFont:[UIFont systemFontOfSize:15]];
    
    lblDate.textColor = [UIColor colorWithRed:100/255.f green:100/255.f blue:100/255.f alpha:0.7];
    lblDate.text = self.daysOfWeek[section];
    [lblDate setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
    
    UIImageView *navigationImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 6, 15, 15)];
    navigationImage.image=[UIImage imageNamed:@"TabCalendar"];
    navigationImage.contentMode = UIViewContentModeScaleAspectFit;


    [view addSubview:lblDate];
    [view setBackgroundColor:[UIColor colorWithRed:216/255.f green:217/255.f blue:216/255.f alpha:0.5]];

    
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *val = self.appData.weekOrders[self.appData.currentEater];
    NSPredicate *theDayEquelSection = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return (section + 1) == ([[evaluatedObject dayOfWeekNumber] integerValue]);
    }];
    NSArray *filteredOrders = [val filteredArrayUsingPredicate:theDayEquelSection];

//    return [filteredOrders count];
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    Order *orderForCurrentSection = [self.appData getOrderForEaterForCurrentEaterBySectionIndex:indexPath.section];

    if (!orderForCurrentSection) {
        EmptyCell *emptyCell = (EmptyCell *)[tableView dequeueReusableCellWithIdentifier:@"EmptyCell"];
        emptyCell.descr.text = @"You do not have order. To make order click here.";
//        emptyCell.mealImage = [UIImageView ][UIImage imageNamed:@"empty_order"];
        [emptyCell.mealImage setImage:[UIImage imageNamed:@"empty_order"]];
        emptyCell.mealImage.contentMode = UIViewContentModeScaleToFill;
        
        [emptyCell.layer setCornerRadius:10.0f];
        [emptyCell.layer setMasksToBounds:YES];
        [emptyCell.layer setBorderWidth:0.1f];
        return emptyCell;
    } else {
    
        MealCell *mealCell = (MealCell *)[tableView dequeueReusableCellWithIdentifier:@"MealCell"];
        mealCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [mealCell.title setText: orderForCurrentSection.meal.title];
        [mealCell.descr setText: orderForCurrentSection.meal.descr];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        mealCell.separatorInset = UIEdgeInsetsZero;
        mealCell.mealImage.contentMode = UIViewContentModeScaleToFill;

        NSString *imageUrl= [NSString stringWithFormat:@"%@%@", BASE_URL, [orderForCurrentSection meal].imagePath];
        NSURL *url = [NSURL URLWithString:imageUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        UIImage *placeholderImage = [UIImage imageNamed:@"none"];

        __weak MealCell *weakCell = mealCell;
        [mealCell.mealImage setImageWithURLRequest:request
                          placeholderImage:placeholderImage
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       weakCell.mealImage.image = image;
                                       [weakCell setNeedsLayout];
                                   } failure: ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                        NSLog(@"%@", error);
                                   }];


        [mealCell.layer setCornerRadius:10.0f];
        [mealCell.layer setMasksToBounds:YES];
        [mealCell.layer setBorderWidth:0.1f];
        return mealCell;
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"GoToMealDetails"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        MealDetailController *detailViewController = (MealDetailController *)segue.destinationViewController;

        Order *order = [self.appData getOrderForEaterForCurrentEaterBySectionIndex:indexPath.section];
        
        //detailViewController.typePage = TypeMealDetailPage.ForView;
        detailViewController.meal = [[Meal alloc] initWithId:order.meal.id
                                                       title:order.meal.title
                                                       descr:order.meal.descr
                                                   allergens:order.meal.allergens
                                                   imagePath:order.meal.imagePath];
        
        detailViewController.typePage = TypeMealDetailPageForView;
    }

    if (([segue.identifier isEqualToString:@"MenuListSegue"])) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        NSInteger rowNumber = 0;
        
        for (NSInteger i = 0; i < indexPath.section; i++) {
            rowNumber += [self.tableView numberOfRowsInSection:i];
        }
        rowNumber += indexPath.row;
        
        MealListViewController *mealListViewController = (MealListViewController *)segue.destinationViewController;
        mealListViewController.day = self.datesOfWeek[rowNumber];
    }
}

@end
