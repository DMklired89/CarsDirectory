//
//  EDVNewCar+CoreDataProperties.h
//  CarsDirectory
//
//  Created by Dmitry Edrenov on 17.02.19.
//  Copyright © 2019 Dmitry Edrenov. All rights reserved.
//

#import "EDVNewCar+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface EDVNewCar (CoreDataProperties)

@property (nullable, nonatomic, copy) NSString *bodyType;
@property (nullable, nonatomic, copy) NSString *carClass;
@property (nullable, nonatomic, copy) NSString *company;
@property (nullable, nonatomic, copy) NSString *model;
@property (nullable, nonatomic, copy) NSString *year;

@end

NS_ASSUME_NONNULL_END
