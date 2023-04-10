//
//  Task.h
//  TodoList
//
//  Created by yomna kerir  on 08/04/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSObject


@property  NSString *taskName;
@property NSString *taskDescription;
@property  NSDate *dateOfCreation;
@property  int taskPriority;
@property  int taskState;


@end

NS_ASSUME_NONNULL_END
