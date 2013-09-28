//
//  CourseListTableViewController.m
//  courseReg
//
//  Created by Mingsheng Xu on 9/28/13.
//  Copyright (c) 2013 Mingsheng Xu. All rights reserved.
//

#import "CourseListTableViewController.h"
#import "API.h"

@interface CourseListTableViewController ()

@end

@implementation CourseListTableViewController
@synthesize courseListJson;
UIAlertView *addAlert;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSString* command = @"showCourseList";
    NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  command, @"command",
                                [[API sharedInstance].user objectForKey:@"username"],@"username",
                                  nil];
    //make the call to the web API
    
     NSLog(@"user is %@",  [[API sharedInstance].user objectForKey:@"username"]);
    [[API sharedInstance] commandWithParams:params
                               onCompletion:^(NSDictionary *json) {
                                   //handle the response
                                   //result returned
                                  
                                   //NSLog(@"res is %@", res);
                                    NSLog(@"json is %@", json);
                                   self.courseListJson=json;
                                   //if successful, i can have a look inside parsedJSON - its worked as an NSdictionary and NSArray
                                   
                                   
                                   
                                   
                                   if ([json objectForKey:@"error"]==nil ) {
                                       //success
                                       [self.tableView reloadData];
                                   } else {
                                       //error
                                       UIAlertView * alertView = [[UIAlertView alloc] initWithTitle: @"My Error" message: [json objectForKey:@"error"] delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
                                       [alertView show];
                                       
                                       
                                   }
                                   
                               }];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
     return [[self.courseListJson objectForKey:@"result"]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Configure the cell...
    
    static NSString *SimpleTableIdentifier = @"SimlpeTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:SimpleTableIdentifier] ;
        
    }
   NSLog(@"%d",[indexPath row]);
    NSDictionary *tempDictionary= [[self.courseListJson objectForKey:@"result"]objectAtIndex:indexPath.row];
    
 
    
    cell.textLabel.text = [tempDictionary objectForKey:@"crn"];
    
    // Configure the cell...
    
    return cell;

    }

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (IBAction)addCourseItem_Press:(UIBarButtonItem *)sender {
    
   addAlert = [[UIAlertView alloc] initWithTitle:@"Add a new item"
                                                       message:@"Please enter a crn"
                                                      delegate:self
                                             cancelButtonTitle:@"Cancel"
                                             otherButtonTitles:@"Add",nil];
    addAlert.tag=1;
    addAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
       //弹出
    [addAlert show];
    
    
}

- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    //If cancel pressed
    if (alertView.tag == 1) {
        if(buttonIndex == 0){
            NSLog(@"点击了确定");
            //myCore=[[toDoListCore alloc] init];
       
            [self.tableView reloadData];
            //If item added pressed
        }else if (buttonIndex == 1){
            NSString* command = @"AddCourseToList";
            NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                          command, @"command",
                                          [[API sharedInstance].user objectForKey:@"username"],@"username",
                                          [[alertView textFieldAtIndex:0] text],@"crn",
                                          nil];
            //make the call to the web API
            NSLog(@"add txt is %@",[[alertView textFieldAtIndex:0] text]);
            NSLog(@"user is %@",  [[API sharedInstance].user objectForKey:@"username"]);
            [[API sharedInstance] commandWithParams:params
                                       onCompletion:^(NSDictionary *json) {
                                           //handle the response
                                           //result returned
                                           
                                           //NSLog(@"res is %@", res);
                                           //NSLog(@"json is %@", json);
                                          
                                           //if successful, i can have a look inside parsedJSON - its worked as an NSdictionary and NSArray
                            
                                           //NSLog(@"res is %@", res);
                                           NSLog(@"json is %@", json);
                                           self.courseListJson=json;
                                           //if successful, i can have a look inside parsedJSON - its worked as an NSdictionary and NSArray

                                           if ([json objectForKey:@"error"]==nil ) {
                                               //success
                                               [self.tableView reloadData];
                                           } else {
                                               //error
                                               UIAlertView * alertView = [[UIAlertView alloc] initWithTitle: @"My Error" message: [json objectForKey:@"error"] delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
                                               [alertView show];
                                               
                                               
                                           }
                                           
                                       }];
            
        }
    }
}
@end
