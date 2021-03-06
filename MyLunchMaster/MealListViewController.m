//
//  MealListViewController.m
//  MyLunchMaster
//
//  Created by Employee on 06.10.15.
//  Copyright (c) 2015 Employee. All rights reserved.
//

#import <AFNetworking/UIImageView+AFNetworking.h>
#import "MealListViewController.h"
#import "MealForOrderCell.h"
#import "Meal.h"
#import "Constants.h"
#import "MealService.h"
#import "AppData.h"
#import "MealDetailController.h"

@interface MealListViewController ()


@property (nonatomic, strong)NSMutableArray *mealList;

@end

@implementation MealListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initProperties];
}

- (void)initProperties {
    MealService *maelService = [[MealService alloc] init];
    
    AppData *appData = [AppData getInstance];
    //self.mealList = [maelService getMealListBy:appData.currentEater.id  andDate:self.day];
    self.mealList = [maelService getMealListBy:@"16759"  andDate:self.day];
    NSLog(@"%@", self.mealList);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.mealList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MealForOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MealForOrderCell" forIndexPath:indexPath];

    Meal *meal = self.mealList[indexPath.row];
    cell.title.text = meal.title;
    cell.descr.text = meal.descr;
    cell.price.text = meal.price;

    cell.mealImage.contentMode = UIViewContentModeScaleToFill;

    NSString *imageUrl= [NSString stringWithFormat:@"%@%@", BASE_URL, meal.imagePath];
    NSURL *url = [NSURL URLWithString:imageUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIImage *placeholderImage = [UIImage imageNamed:@"none"];


    
    __weak MealForOrderCell *weakCell = cell;

    [cell.mealImage setImageWithURLRequest:request
                          placeholderImage:placeholderImage
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                              weakCell.mealImage.image = image;
                                              [weakCell setNeedsLayout];
                                           }
                                   failure: ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                              NSLog(@"%@", error);
                                           }];

    [cell.layer setCornerRadius:10.0f];
    [cell.layer setMasksToBounds:YES];
    [cell.layer setBorderWidth:0.1f];
    
    cell.delegate = self;
    cell.cellIndex = indexPath.row;
    if (self.mealList)
    cell.imgOk.hidden = YES;

    
    return cell;
}

- (void)didClickOnCellAtIndex:(NSInteger)cellIndex withData:(id)data
{
    // Do additional actions as required.
    //NSLog(@"Cell at Index: %d clicked.\n Data received : %@", cellIndex, data);


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
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    MealDetailController *detailViewController = (MealDetailController *)segue.destinationViewController;
    
    Meal *meal = (Meal *)self.mealList[indexPath.row];
    
    detailViewController.meal = meal;
    detailViewController.typePage = TypeMealDetailPageForOrder;
    detailViewController.selectedDate = self.day;
}


#pragma mark - ViewInterface implement

- (void)setDayOfWeek:(NSString *)dayOfWeek {

}

- (void)setCurrentDate:(NSString *)currentDate {

}

- (void)updateMealList:(NSMutableArray *)mealListParam {
    if (mealListParam) {
        self.mealList = mealListParam;
    }

    [self.tableView reloadData];
}


@end
