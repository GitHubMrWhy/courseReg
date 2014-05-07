//
//  TradeTableViewController.m
//  courseReg
//
//  Created by Mingsheng Xu on 9/22/13.
//  Copyright (c) 2013 Mingsheng Xu. All rights reserved.
//

#import "TradeTableViewController.h"
#import "API.h"
#import "TradeItemDetailTableViewController.h"
@interface TradeTableViewController ()

@end

@implementation TradeTableViewController
@synthesize listData;

@synthesize nsjson;
@synthesize array;

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
    
    [self showTradeList];

}
-(void)showTradeList{
    NSString* command = @"showTradeList";
    NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  command, @"command",
                                  
                                  nil];
    //make the call to the web API
    [[API sharedInstance] commandWithParams:params
                               onCompletion:^(NSDictionary *json) {
                                   //handle the response
                                   //result returned
                                   NSDictionary* res = [[json objectForKey:@"result"] objectAtIndex:0];
                                   //NSLog(@"res is %@", res);
                                   // NSLog(@"json is %@", json);
                                   self.nsjson=json;
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
     return [[self.nsjson objectForKey:@"result"]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"SimlpeTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
       if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:SimpleTableIdentifier] ;
        
    }
    //NSLog(@"%d",[indexPath row]);
    NSDictionary *tempDictionary= [[self.nsjson objectForKey:@"result"]objectAtIndex:indexPath.row];
    
    cell.detailTextLabel.text = [tempDictionary objectForKey:@"crn"];
    
    cell.textLabel.text = [tempDictionary objectForKey:@"course_number"];

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

#pragma mark - Navigation
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(id)sender
{
    [self performSegueWithIdentifier:@"TradeListToTradeItemDetail" sender:self];
}

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([segue.identifier isEqualToString:@"TradeListToTradeItemDetail"])
    {
         TradeItemDetailTableViewController *transferViewController = segue.destinationViewController;
        transferViewController.crn =[[[self.nsjson objectForKey:@"result"] objectAtIndex:[self.tableView indexPathForSelectedRow].row]objectForKey:@"crn"];
        transferViewController.userPost =[[[self.nsjson objectForKey:@"result"] objectAtIndex:[self.tableView indexPathForSelectedRow].row]objectForKey:@"user"];
        transferViewController.courseNum = [[[self.nsjson objectForKey:@"result"] objectAtIndex:[self.tableView indexPathForSelectedRow].row]objectForKey:@"course_number"];
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}




@end
