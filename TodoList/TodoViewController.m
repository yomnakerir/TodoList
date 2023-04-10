//
//  TodoViewController.m
//  TodoList
//
//  Created by yomna kerir  on 08/04/2023.
//
#import "Task.h"
#import "TodoViewController.h"
#import "AddNewTaskViewController.h"
#import "DetailsTaskViewController.h"

@interface TodoViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *search;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TodoViewController{
    NSUserDefaults *def;
    NSMutableArray<Task*> *ArrofTask;
    Task*task;
    NSMutableArray* selectedTask;//search
    BOOL isSelected; //search
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.delegate=self;
   _tableView.dataSource=self;
    task=[Task new];
    isSelected=NO;  //search
    _search.delegate=self;  //search
  
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    def=[NSUserDefaults standardUserDefaults];
    ArrofTask=[[self loadTasks:@"task"]mutableCopy];
    [_tableView reloadData];
}


//search
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length==0)
    {
        isSelected=NO;
    }
    else
    {
        isSelected=YES;
        selectedTask=[[NSMutableArray alloc]init];
        for (int i=0; i<ArrofTask.count; i++)
        {
            if ([ArrofTask[i].taskName hasPrefix:searchText] || [ArrofTask[i].taskName hasPrefix:[searchText lowercaseString]])
            {
                    [selectedTask addObject:ArrofTask[i]];
            }
        }
    }
    [_tableView reloadData];
}



- (IBAction)addNewTask:(id)sender {
    
    AddNewTaskViewController *newTaskScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"newTaskScreen"];
    [self.navigationController pushViewController:newTaskScreen animated: YES];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"TASKS";
} */


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
  
    //search
    
    if(isSelected)
    {
        cell.textLabel.text=[[selectedTask objectAtIndex:indexPath.row] taskName];
        if([[selectedTask objectAtIndex:indexPath.row] taskPriority]==0)
        {
            cell.imageView.tintColor = [UIColor yellowColor];
            //cell.imageView.image = [cell.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        }
        else if ([[selectedTask objectAtIndex:indexPath.row] taskPriority]==1)
        {
            cell.imageView.tintColor = [UIColor greenColor];
           // cell.imageView.image = [cell.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        }
        else
        {
            cell.imageView.tintColor = [UIColor redColor];
           // cell.imageView.image = [cell.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        }
    }

    
    //search
        
     
            else

            
    {
        cell.textLabel.text=[[ArrofTask objectAtIndex:indexPath.row] taskName ];
    
        if([[ArrofTask objectAtIndex:indexPath.row] taskPriority]==0)
        {
            cell.imageView.tintColor = [UIColor yellowColor];
            //cell.imageView.image = [cell.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        }
        else if ([[ArrofTask objectAtIndex:indexPath.row] taskPriority]==1)
        {
            cell.imageView.tintColor = [UIColor greenColor];
           // cell.imageView.image = [cell.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        }
        else //this because but read if doesn't chose
        {
            cell.imageView.tintColor = [UIColor redColor];
           // cell.imageView.image = [cell.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        }
    }
    
   
    return  cell;
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    //search
    
    if (isSelected)
    {
        if ([selectedTask count]!=0)
        {
            _tableView.hidden = false;
        }
        else
        {
            _tableView.hidden = true;
        }
        return selectedTask.count;
    }

    else
    {
        if ([ArrofTask count]!=0)
        {
            _tableView.hidden = false;

        }
        else
        {
            _tableView.hidden = true;

        }
    //search
        return ArrofTask.count;
    //search
    }
    //search

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //make Alert
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"delete task" message:@"do you want delete?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    //Creat buttons
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action)
                         {
        
        //code
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [ArrofTask removeObjectAtIndex:indexPath.row];
        [_tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        def=[NSUserDefaults standardUserDefaults];
        [self saveTasks:@"task" withArray:ArrofTask];
        [_tableView reloadData];
        
    }
    //
    }];

    
    UIAlertAction *no = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:nil];
    
    //add buttons
    [alert addAction:ok];
    [alert addAction:no];
    
    //show alert
    [self presentViewController:alert animated:YES completion:nil];
}


 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     DetailsTaskViewController *detailsScreen=[self.storyboard instantiateViewControllerWithIdentifier:@"detailsScreen"];
     
     detailsScreen.task=[ArrofTask objectAtIndex:indexPath.row];
 //    [view setIndex:indexPath.row];
     detailsScreen.x=0;
     [self.navigationController pushViewController:detailsScreen animated:YES];
     
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
    NSArray *myArray = [[NSKeyedUnarchiver unarchiveObjectWithData:data]mutableCopy];
    return myArray;
}



@end
