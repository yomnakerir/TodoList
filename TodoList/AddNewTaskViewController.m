//
//  AddNewTaskViewController.m
//  TodoList
//
//  Created by yomna kerir  on 08/04/2023.
//

#import "AddNewTaskViewController.h"
#import "TodoViewController.h"
#import "Task.h"

@interface AddNewTaskViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *desc;

@property (weak, nonatomic) IBOutlet UIDatePicker *date;

@property (weak, nonatomic) IBOutlet UISegmentedControl *piriorty;

@end

@implementation AddNewTaskViewController{

    Task *task;
    NSMutableArray *arrOFtask;
    NSUserDefaults *def;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    def =[NSUserDefaults standardUserDefaults];
    task = [Task new];
    arrOFtask=[[self loadTasks:@"task"]mutableCopy];
  
}

- (IBAction)addTask:(id)sender {
    
    // alert
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add task" message:@"do you want add?" preferredStyle:UIAlertControllerStyleAlert];
    
    //Creat buttons
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action)
                         {
        
        //code
    
    task.taskName = _name.text;
    task.taskDescription = _desc.text;
    task.taskPriority = _piriorty.selectedSegmentIndex;
    task.dateOfCreation = _date.date;
    [arrOFtask addObject:task];
    [self saveTasks:@"task" withArray:arrOFtask];
    [self.navigationController popViewControllerAnimated:YES];
        
        
    }];
    
    
    
    UIAlertAction *no = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:nil];
    
    //add buttons
    [alert addAction:ok];
    [alert addAction:no];
    
    //show alert
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
   // TodoViewController *todoScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"todoScreen"];
    
    //[self.navigationController pushViewController:todoScreen animated: YES];
}

-(void)saveTasks:(NSString *)keyName withArray:(NSMutableArray *)myArray
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myArray];
    [def setObject:data forKey:keyName];
    [def synchronize];
}

-(NSArray *)loadTasks:(NSString*)keyName
{
    NSData *data = [def objectForKey:keyName];
    NSArray *myArray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    return myArray;
}













@end
