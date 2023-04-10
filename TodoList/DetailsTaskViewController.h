//
//  DetailsTaskViewController.h
//  TodoList
//
//  Created by yomna kerir  on 08/04/2023.
//

#import <UIKit/UIKit.h>
#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsTaskViewController : UIViewController
@property Task* task;
@property int index;
@property int x;

@end

NS_ASSUME_NONNULL_END
