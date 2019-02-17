//
//  EDVCarTableViewController.m
//  CarsDirectory
//
//  Created by Dmitry Edrenov on 17.02.19.
//  Copyright © 2019 Dmitry Edrenov. All rights reserved.
//

#import "EDVCarTableViewController.h"
#import "AppDelegate.h"
#import "EDVNewCar+CoreDataClass.h"
#import "EDVNewCar+CoreDataProperties.h"
#import "EDVCarDetailViewController.h"

@interface EDVCarTableViewController ()

// Array for cars
@property (nonatomic, strong) NSMutableArray *cars;

@end

@implementation EDVCarTableViewController

// managedObjectContext for cars objects
-(NSManagedObjectContext *) managedObjectContext {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [[delegate persistentContainer] viewContext];
    return context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

// Create fetchRequest
-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName: @"EDVNewCar"];
    self.cars = [[managedObjectContext executeFetchRequest: fetchRequest error: nil] mutableCopy];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Ability to editing cell
-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// Swipe for delete
-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // If swipe = delete, object will be deleted
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [context deleteObject: [self.cars objectAtIndex: indexPath.row]];
        NSError *error = nil;
        if (![context save: &error]) {
            NSLog(@"Not deleted! %@ %@", error, [error localizedDescription]);
            return;
        }
        [self.cars removeObjectAtIndex: indexPath.row];
        [self.tableView deleteRowsAtIndexPaths: [NSArray arrayWithObject: indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cars.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"newCarCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier forIndexPath:indexPath];
    EDVNewCar *car = [self.cars objectAtIndex: indexPath.row];
    [cell.textLabel setText: [NSString stringWithFormat: @"%@   %@   %@", car.company, car.model, car.year]];
    [cell.detailTextLabel setText: [NSString stringWithFormat: @"%@    %@", car.carClass, car.bodyType]];
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString: @"updateCar"]) {
        EDVNewCar *selectedCar = [self.cars objectAtIndex: [[self.tableView indexPathForSelectedRow]row]];
        EDVCarDetailViewController *destViewController = segue.destinationViewController;
        destViewController.car = selectedCar;
    }
}

@end
