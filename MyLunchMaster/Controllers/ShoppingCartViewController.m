//
//  ShoppingCartViewController.m
//  MyLunchMaster
//
//  Created by Employee on 29.09.15.
//  Copyright (c) 2015 Employee. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "AppData.h"
#import "HttpApiHelper.h"
#import "JsonParserHelper.h"
#import "OrderDetailCellTableViewCell.h"
#import <CoreData/CoreData.h>

@interface ShoppingCartViewController ()

@property (nonatomic, strong) AppData *appData;
@property (nonatomic, strong) HttpApiHelper *httpClient;
@property (nonatomic, strong) JsonParserHelper *jsonParserHelper;

@property (nonatomic, strong) NSMutableArray *amounts;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initProperties];

    UIImageView *navigationImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 130, 15)];
    navigationImage.image=[UIImage imageNamed:@"Logo"];
    UIImageView *workaroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 130, 15)];
    [workaroundImageView addSubview:navigationImage];
    self.navigationItem.titleView=workaroundImageView;
    
    NSLog(@"ShoppingCartViewController view did load");
    
     [[self httpClient] getShoppingCartSuccess:^(AFHTTPRequestOperation *task, id responseObject) {
                                                    NSArray *orderItems = [responseObject valueForKeyPath:@"order_items"];

                                                 [orderItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

                                                     NSString *eaterName = [obj valueForKey:@"eater"];
                                                     NSArray *orders = [obj valueForKey:@"items"];

                                                     [orders enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

                                                         NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Order" inManagedObjectContext:[self managedObjectContext]];
                                                         NSManagedObject *newOrder = [[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:[self managedObjectContext]];
                                                         [newOrder setValue:[obj valueForKey:@"id"] forKey:@"id"];
                                                         [newOrder setValue:[obj valueForKey:@"menu_item"] forKey:@"meal_descr"];
                                                         [newOrder setValue:[obj valueForKey:@"meal_size"] forKey:@"meal_size"];
                                                         [newOrder setValue:[obj valueForKey:@"meal_date"] forKey:@"meal_date"];
                                                         [newOrder setValue:[obj valueForKey:@"price"] forKey:@"price"];
                                                         [newOrder setValue:eaterName forKey:@"eater"];
                                                     }];

                                                 }];

                                                 NSError *error = nil;
                                                 // Save the object to persistent store
                                                 if (![[self managedObjectContext] save:&error]) {
                                                     NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                                                 }

                                                    [self.tableView reloadData];
                 [[self navigationController] tabBarItem].badgeValue = [NSString stringWithFormat: @"%ld", (long)orderItems.count];


                                                }
                                       failure:^(AFHTTPRequestOperation *task, NSError *error) {}];
    
}

- (void)initProperties {
    [self setAppData:[AppData getInstance]];
    [self setHttpClient:[HttpApiHelper httpClient]];
    [self setJsonParserHelper:[JsonParserHelper getInstance]];

    self.amounts = [[NSMutableArray alloc] init];

    NSDictionary *elem1 = @{@"Petr Smith" : @"$0.20"};
    NSDictionary *elem2 = @{@"Adjustments" : @"$0.00"};
    NSDictionary *elem3 = @{@"Due" : @"$0.20"};
    NSDictionary *elem4 = @{@"Paid" : @"$0.00"};
    NSDictionary *elem5 = @{@"Credit" : @"$0.00"};

    [self.amounts addObject:elem1];
    [self.amounts addObject:elem2];
    [self.amounts addObject:elem3];
    [self.amounts addObject:elem4];
    [self.amounts addObject:elem5];

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Order"];
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"meal_date" ascending:YES]]];

    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[self managedObjectContext] sectionNameKeyPath:nil cacheName:nil];

    // Configure Fetched Results Controller
    [self.fetchedResultsController setDelegate:self];

    // Perform Fetch
    NSError *error = nil;
    [self.fetchedResultsController performFetch:&error];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    if (section == 0) {
        NSArray *sections = [self.fetchedResultsController sections];
        id<NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
        return [sectionInfo numberOfObjects];
    } else {
        return 5;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        OrderDetailCellTableViewCell *cell;
         cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCartCell" forIndexPath:indexPath];

        NSManagedObject *record = [self.fetchedResultsController objectAtIndexPath:indexPath];


        [cell.eaterName setText:[record valueForKey:@"eater"]];
        [cell.mealDescr setText:[record valueForKey:@"meal_descr"]];
        [cell.dateOrder setText:[record valueForKey:@"meal_date"]];
        NSString *size = (NSString *) [record valueForKey:@"meal_size"];
        [cell.size setText: [size substringToIndex:1].uppercaseString];
        [cell.price setText:[record valueForKey:@"price"]];

        //[cell.imgDelete setTintColor:[UIColor blueColor]];

        cell.imgDelete.image = [cell.imgDelete.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [cell.imgDelete setTintColor:[UIColor blueColor]];

        return cell;
    } else {
        UITableViewCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:@"AmountCell" forIndexPath:indexPath];

        NSDictionary *elem = [self.amounts objectAtIndex:indexPath.row];
        [cell.textLabel setText:elem.allKeys[0]];
        [cell.detailTextLabel setText: elem.allValues[0]];
        return cell;
    }
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewCell *headerView;
    if (section == 0) {
        static NSString *CellIdentifier = @"OrdersHeader";
        headerView = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    } else {
        static NSString *CellIdentifier = @"AmountHeader";
        headerView = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }

    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 65;
    } else {
        return 30;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 60;
    } else {
        return 45;
    }
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "Work.CoreDataTestApp" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"LMModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"LMModel.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    
    NSDictionary *options = @{ NSMigratePersistentStoresAutomaticallyOption : @(YES),
                               NSInferMappingModelAutomaticallyOption : @(YES) };
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Implement NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeDelete: {
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeUpdate: {
//            static NSString *CellIdentifier = @"OrderCartCell";
//            UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//            NSManagedObject *record = [self.fetchedResultsController objectAtIndexPath:indexPath];
//
//            // Update Cell
//            [cell.textLabel setText:[record valueForKey:@"meal_descr"]];
//            [cell.detailTextLabel setText:[record valueForKey:@"price"]];

            break;
        }
        case NSFetchedResultsChangeMove: {
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
    }
}

@end
