//
//  DoneViewController.m
//  TodoList
//
//  Created by yomna kerir  on 08/04/2023.
//

#import "DoneViewController.h"
#import "Task.h"

@interface DoneViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DoneViewController{
    NSUserDefaults *def;
    NSMutableArray<Task*> *ArrofTask;
    Task*task;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView.delegate=self;
    _tableView.dataSource=self;
    task=[Task new];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    def = [NSUserDefaults standardUserDefaults];
    ArrofTask = [[self loadTasks:@"done"]mutableCopy];
    [_tableView reloadData];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellD"];
    

    //cell.textLabel.text = @"yomna";
  
    //cell.imageView

        cell.textLabel.text=[[ArrofTask objectAtIndex:indexPath.row] taskName ];
        if([[ArrofTask objectAtIndex:indexPath.row] taskPriority]==0){
            cell.imageView.tintColor = [UIColor yellowColor];
           // cell.imageView.image = [cell.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        }else if ([[ArrofTask objectAtIndex:indexPath.row] taskPriority]==1){
            cell.imageView.tintColor = [UIColor greenColor];
           // cell.imageView.image = [cell.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        }else{
            cell.imageView.tintColor = [UIColor redColor];
           // cell.imageView.image = [cell.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        }
    return  cell;

   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return ArrofTask.count;
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
        [self saveTasks:@"done" withArray: ArrofTask];
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
