//
//  DetailsTaskViewController.m
//  TodoList
//
//  Created by yomna kerir  on 08/04/2023.
//

#import "DetailsTaskViewController.h"

@interface DetailsTaskViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameDetailsTF;
@property (weak, nonatomic) IBOutlet UITextField *desDetailsTF;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priorityDetails;
@property (weak, nonatomic) IBOutlet UISegmentedControl *stateDetails;
@property (weak, nonatomic) IBOutlet UIDatePicker *dateDetails;

@end

@implementation DetailsTaskViewController{
    
    NSMutableArray<Task*>*arrOFtask;  //all array
    Task *task;
    NSUserDefaults *def;
    NSMutableArray* array; //in progres array
    NSMutableArray* doneArray; //done array progres array
    int x;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _nameDetailsTF.text=_task.taskName;
    _desDetailsTF.text=_task.taskDescription;
    _priorityDetails.selectedSegmentIndex=_task.taskPriority;
    _dateDetails.date=_task.dateOfCreation;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    def=[NSUserDefaults standardUserDefaults];
    arrOFtask=[[self loadTasks:@"task"]mutableCopy]; //save all
    array=[[self loadTasks:@"inProgress"]mutableCopy]; //Progress
    doneArray=[[self loadTasks:@"done"]mutableCopy]; // done

}



- (IBAction)updateDetails:(id)sender {
    
    if(_stateDetails.selectedSegmentIndex == 0)
    {
        // on the left task on the right details 
        [[arrOFtask objectAtIndex:_index] setTaskName:_nameDetailsTF.text];
        [[arrOFtask objectAtIndex:_index] setTaskDescription:_desDetailsTF.text];
        [[arrOFtask objectAtIndex:_index] setDateOfCreation:_dateDetails.date];
        [[arrOFtask objectAtIndex:_index] setTaskPriority:_priorityDetails.selectedSegmentIndex];
        [self saveTasks:@"task" withArray:arrOFtask];
        x=0;
        [self.navigationController popViewControllerAnimated:YES];
       
    }
    
    //arrOFtask   Progress
    else if (_stateDetails.selectedSegmentIndex == 1)
    {
        task=[Task new];
        task.taskName =_nameDetailsTF.text;
        task.dateOfCreation=_dateDetails.date;
        task.taskDescription=_desDetailsTF.text;
        task.taskPriority =_priorityDetails.selectedSegmentIndex;
        [arrOFtask removeObjectAtIndex:_index];
        
        [self saveTasks:@"task" withArray:arrOFtask];
        
        
        [array addObject:task];
        [self saveTasks:@"inProgress" withArray:array]; //array is a Progress array
        x=1;

        [self.navigationController popViewControllerAnimated:YES];
    }
    
    //done
    else if (_stateDetails.selectedSegmentIndex == 2)
    {
        if(_x==0)
        {
            task=[Task new];
            task.taskName =_nameDetailsTF.text;
            task.dateOfCreation=_dateDetails.date;
            task.taskDescription=_desDetailsTF.text;
            task.taskPriority =_priorityDetails.selectedSegmentIndex;
            [arrOFtask removeObjectAtIndex:_index];
            
            [self saveTasks:@"task" withArray:arrOFtask]; //to Do
            
            [doneArray addObject:task];
            [self saveTasks:@"done" withArray:doneArray];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        else if (_x==1)
        {
            task=[Task new];
            task.taskName =_nameDetailsTF.text;
            task.dateOfCreation=_dateDetails.date;
            task.taskDescription=_desDetailsTF.text;
            task.taskPriority =_priorityDetails.selectedSegmentIndex;
            
            [array removeObjectAtIndex:_index];
            
            [self saveTasks:@"inProgress" withArray:array]; // in progress
            
            [doneArray addObject:task];
            [self saveTasks:@"done" withArray:doneArray];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
}





-(NSArray *)loadTasks:(NSString*)keyName
{
    NSData *data = [def objectForKey:keyName];
    NSArray *myArray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    return myArray;
}
-(void)saveTasks:(NSString *)keyName withArray:(NSMutableArray *)myArray
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myArray];
    [def setObject:data forKey:keyName];
    [def synchronize];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
