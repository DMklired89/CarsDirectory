//
//  EDVCarDetailViewController.h
//  CarsDirectory
//
//  Created by Dmitry Edrenov on 17.02.19.
//  Copyright © 2019 Dmitry Edrenov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EDVNewCar;

@interface EDVCarDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *yearOfIssueField;
@property (weak, nonatomic) IBOutlet UITextField *modelField;
@property (weak, nonatomic) IBOutlet UITextField *companyField;
@property (weak, nonatomic) IBOutlet UITextField *classField;
@property (weak, nonatomic) IBOutlet UITextField *bodyTypeField;
@property (strong, nonatomic) EDVNewCar *car;

- (IBAction)saveButton:(id)sender;

@end
