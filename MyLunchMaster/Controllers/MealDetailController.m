//
// Created by Employee on 18.09.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import "MealDetailController.h"
#import "Order.h"
#import "Meal.h"
#import "Constants.h"
#import "UIImageView+AFNetworking.h"
#import "MealDetailsService.h"
#import "AppData.h"


@interface MealDetailController()

@property (nonatomic, strong) NSArray *pickerArray;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerMealSize;

@property (weak, nonatomic) IBOutlet UILabel *lblprice;
@property (weak, nonatomic) IBOutlet UIButton *btnMakeOrder;

@end

@implementation MealDetailController {
   

}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initProperties];
    
    self.txtTitle.text = [self.meal title];
    self.txtAlergents.text = [self.meal allergens];
    self.txtDescription.text = [self.meal descr];

    NSString *imageUrl= [NSString stringWithFormat:@"%@%@", BASE_URL, self.meal.imagePath];

    NSURL *url = [NSURL URLWithString:imageUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIImage *placeholderImage = [UIImage imageNamed:@"none"];


    self.imageMeal.contentMode = UIViewContentModeScaleAspectFill;
    [self.imageMeal setImageWithURLRequest:request
                          placeholderImage:placeholderImage
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       self.imageMeal.image = image;

                                   } failure: ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                NSLog(@"%@", error);
            }];
}

- (void)initProperties {
    self.pickerArray = [[NSArray alloc] initWithObjects:@"small", @"middle", @"big", nil];
    self.pickerMealSize.dataSource = self;
    self.pickerMealSize.delegate = self;
    
    if (self.typePage == TypeMealDetailPageForView) {
        self.btnMakeOrder.hidden = YES;
        self.lblprice.hidden = YES;
        self.pickerMealSize.hidden = YES;
    }
}

#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.pickerArray count];
}

#pragma mark- Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.pickerArray objectAtIndex:row];
}
- (IBAction)btnMakeOrderTapped:(id)sender {
    
    MealDetailsService *mealDetailsService = [[MealDetailsService alloc] init];
    [mealDetailsService addMealToCart:[NSString stringWithFormat:@"%@", self.meal.id]
                              forUser:[NSString stringWithFormat:@"%@", [[[AppData getInstance] currentEater] id]]
                              forDate:self.selectedDate
                              success:^(AFHTTPRequestOperation *task, id responseObject) {
                                  
                              }
                              failure:^(AFHTTPRequestOperation *task, NSError *error) {
                                  
                              }];
}

@end