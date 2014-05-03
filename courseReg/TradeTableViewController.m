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
#import "TradeItemTableViewCell.h"
@interface TradeTableViewController ()

@end

@implementation TradeTableViewController
@synthesize listData;

@synthesize nsjson;
@synthesize array;
@synthesize passInfo;
UIAlertView *addAlert;
UIRefreshControl *refreshControl;




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
    
   
    // Refresh
    // 创建UIRefreshControl实例
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to refresh"];
    
    // 设置下拉事件的响应方法
    [refreshControl addTarget:self
                       action:@selector(refreshTableView:)
             forControlEvents:UIControlEventValueChanged];
    // 赋值给UITableViewController
    [self.tableView addSubview:refreshControl];
     [self showTradeList];

}
- (void) viewWillAppear:(BOOL)animated
{
    [self showTradeList];
    [self.tableView reloadData];
    
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
                                  
                                   //NSLog(@"res is %@", res);
                                   //NSLog(@"json is %@", json);
                                   
                                   //if successful, i can have a look inside parsedJSON - its worked as an NSdictionary and NSArray
                                   
                                   if ([json objectForKey:@"error"]==nil ) {
                                       self.nsjson=json;
                                       //success
                                       [self.tableView reloadData];
                                   } else {
                                       //error
                                       UIAlertView * alertView = [[UIAlertView alloc] initWithTitle: @"My Error" message: [json objectForKey:@"error"] delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
                                       [alertView show];
                                       
                                   }
                                   
                               }];
    
    


}

-(void) refreshTableView:(UIRefreshControl *) controller
{
    if (controller.refreshing) {
        controller.attributedTitle = [[NSAttributedString alloc]initWithString:@"Loading..."];
        //添加新的模拟数据
        //NSLog(@"下拉刷新请求");
        //模拟请求完成之后，回调方法callBackMethod
        [self performSelector:@selector(callBackMethod) withObject:nil afterDelay:0];
    }
    
}

-(void)callBackMethod

{
    [self showTradeList];
    [self.tableView reloadData];
    [refreshControl endRefreshing];
    refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"Pull to refresh"];
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
       TradeItemTableViewCell *cell = (TradeItemTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TradeItemTableViewCell"];
 
   
               //NSLog(@"%d",[indexPath row]);
    NSDictionary *tempDictionary= [[self.nsjson objectForKey:@"result"]objectAtIndex:indexPath.row];
    
    NSString* fontName = @"Optima-Italic";
    NSString* boldFontName = @"Optima-ExtraBlack";
    
    UIColor* mainColor = [UIColor colorWithRed:50.0/255 green:102.0/255 blue:147.0/255 alpha:1.0f];
    cell.exchangeLabel.textColor =  mainColor;
    cell.exchangeLabel.font =  [UIFont fontWithName:fontName size:14.0f];
    
    cell.haveLabel.textColor =  mainColor;
    cell.haveLabel.font =  [UIFont fontWithName:fontName size:14.0f];

    if([[tempDictionary objectForKey:@"have"] isEqualToString:@""]){
       cell.haveLabel.text =[NSString stringWithFormat:@"%@ have nothing",[tempDictionary objectForKey:@"username"]];
    }else{
        cell.haveLabel.text =[NSString stringWithFormat:@"%@ have %@",[tempDictionary objectForKey:@"username"],[tempDictionary objectForKey:@"have"]];
        
    }
    if([[tempDictionary objectForKey:@"exchange" ] isEqualToString:@""]){
        cell.exchangeLabel.text =[NSString stringWithFormat:@" to trade nothing"];
    }else{
       cell.exchangeLabel.text =[NSString stringWithFormat:@" to trade %@",[tempDictionary objectForKey:@"exchange"]];
    }
    NSString *photoURL1 = @"http://www.mingshengxu.com/promos/img/";
    NSString *photoURL = [NSString stringWithFormat:@"%@%@_profile.jpg",photoURL1,[tempDictionary objectForKey:@"username"]];
    
    [cell.profileImageView setImageWithURL:[NSURL URLWithString:photoURL] ];
    cell.accessoryType =   UITableViewCellAccessoryDisclosureIndicator;
    // Configure the cell...
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
        // Delete the row from the data source
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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
- (IBAction)addTradeItem_Press:(UIBarButtonItem *)sender {
    
    [self performSegueWithIdentifier:@"TradeListToAddItem" sender:self];
    
}

#pragma mark - Navigation
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(id)sender
{
    NSString* command = @"showInfo";
    NSString *user = [[[self.nsjson objectForKey:@"result"] objectAtIndex:[self.tableView indexPathForSelectedRow].row] objectForKey:@"username"];
    NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  command, @"command",
                                  user,@"username",
                                  nil];
    //make the call to the web API
    [[API sharedInstance] commandWithParams:params
                               onCompletion:^(NSDictionary *json) {
                                   if ([json objectForKey:@"error"]==nil ) {
                                       self.passInfo=[[json objectForKey:@"result"] objectAtIndex:0];
                                       
                                   } else {
                                       //error
                                       UIAlertView * alertView = [[UIAlertView alloc] initWithTitle: @"My Error" message: [json objectForKey:@"error"] delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
                                       [alertView show];
                                       
                                   }
                                   
                               }];
    

    [self performSegueWithIdentifier:@"TradeListToTradeItemDetail" sender:self];
}

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([segue.identifier isEqualToString:@"TradeListToTradeItemDetail"])
    {
         TradeItemDetailTableViewController *transferViewController = segue.destinationViewController;
       transferViewController.tempDictionary =[[self.nsjson objectForKey:@"result"] objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        transferViewController.info= self.passInfo;
        }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"TradeListToAddItem"])
    {
        TradeItemDetailTableViewController *transferViewController = segue.destinationViewController;
       
    }

}


@end
