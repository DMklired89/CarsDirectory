//
//  EDVCarDetailViewController.m
//  CarsDirectory
//
//  Created by Dmitry Edrenov on 17.02.19.
//  Copyright © 2019 Dmitry Edrenov. All rights reserved.
//

#import "EDVCarDetailViewController.h"
#import "EDVNewCar+CoreDataClass.h"
#import "EDVNewCar+CoreDataProperties.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface EDVCarDetailViewController () <UITextFieldDelegate>

@end

@implementation EDVCarDetailViewController

// managedObjectContext for cars objects
-(NSManagedObjectContext *) managedObjectContext {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [[delegate persistentContainer] viewContext];
    return context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // For editing cell
    if (self.car) {
        [self.yearOfIssueField setText: [self.car valueForKey: @"year"]];
        [self.modelField setText: [self.car valueForKey: @"model"]];
        [self.companyField setText: [self.car valueForKey: @"company"]];
        [self.classField setText: [self.car valueForKey: @"carClass"]];
        [self.bodyTypeField setText: [self.car valueForKey: @"bodyType"]];
    }
    
    // To minimize keyboard by touching screen
    UITapGestureRecognizer *handleTap = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(handleEndEditing)];
    [self.view addGestureRecognizer: handleTap];
}

// hanfleTap method
-(void) handleEndEditing {
    [self.yearOfIssueField resignFirstResponder];
    [self.modelField resignFirstResponder];
    [self.companyField resignFirstResponder];
    [self.classField resignFirstResponder];
    [self.bodyTypeField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Save button
- (IBAction)saveButton:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];    
    if (self.car) {
        [self.car setValue: self.yearOfIssueField.text forKey: @"year"];
        [self.car setValue: self.modelField.text forKey: @"model"];
        [self.car setValue: self.companyField.text forKey: @"company"];
        [self.car setValue: self.classField.text forKey: @"carClass"];
        [self.car setValue: self.bodyTypeField.text forKey: @"bodyType"];
    }
    else {
        EDVNewCar *newCar = [NSEntityDescription insertNewObjectForEntityForName: @"EDVNewCar" inManagedObjectContext: context];
        [newCar setValue: self.yearOfIssueField.text forKey: @"year"];
        [newCar setValue: self.modelField.text forKey: @"model"];
        [newCar setValue: self.companyField.text forKey: @"company"];
        [newCar setValue: self.classField.text forKey: @"carClass"];
        [newCar setValue: self.bodyTypeField.text forKey: @"bodyType"];
    }
    
    // Saving error
    NSError *error = nil;
    // If context not saved
    if (![context save: &error]) {
        // Error and error with description
        NSLog(@"Can't save! %@ %@", error, [error localizedDescription]);
    }
    else {
        NSLog(@"YEAH!");
    }
}

// Return button settings to minimize keyboard
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual: self.yearOfIssueField]) {
        [self.yearOfIssueField resignFirstResponder];
    }
    if ([textField isEqual: self.modelField]) {
        [self.modelField resignFirstResponder];
    }
    if ([textField isEqual: self.companyField]) {
        [self.companyField resignFirstResponder];
    }
    if ([textField isEqual: self.classField]) {
        [self.classField resignFirstResponder];
    }
    if ([textField isEqual: self.bodyTypeField]) {
        [self.bodyTypeField resignFirstResponder];
    }
    return YES;
}

@end
