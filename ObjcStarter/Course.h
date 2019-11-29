//
//  Course.h
//  ObjcStarter
//
//  Created by Nursultan on 22/11/2019.
//  Copyright © 2019 Nursultan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Course : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *numberOfLessons;

@end

NS_ASSUME_NONNULL_END
