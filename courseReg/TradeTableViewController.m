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

@property (nonatomic, strong) UIRefreshControl *refreshControl;

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
>>>>>>> FETCH_HEAD

- (void)viewDidLoad {
    [super viewDidLoad];
    
<<<<<<< HEAD
    // Refresh
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to refresh"];
    [refreshControl addTarget:self
                       action:@selector(refreshTableView:)
             forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    [self.tableView addSubview:refreshControl];
}
=======
    
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
>>>>>>> FETCH_HEAD

- (void)viewWillAppear:(BOOL)animated {
    [self showTradeList];
}
<<<<<<< HEAD

- (void)showTradeList {
    self.array = [NSMutableArray array];
    self.searchresult = [NSMutableArray array];
    
=======
- (void) viewWillAppear:(BOOL)animated
{
    [self showTradeList];
    [self.tableView reloadData];
    
}

-(void)showTradeList{
>>>>>>> FETCH_HEAD
    NSString* command = @"showTradeList";
    NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  command, @"command",
                                  nil];
    
    //make the call to the web API
    [[API sharedInstance] commandWithParams:params
                               onCompletion:^(NSDictionary *json) {
<<<<<<< HEAD
                                   //NSLog(@"res is %@", res);
                                   //NSLog(@"json is %@", json);
                                   if ([json objectForKey:@"error"]==nil ) {
                                       self.nsjson=json;
                                       self.array = [self.nsjson objectForKey:@"result"];
                                       self.searchresult = [[NSArray alloc] initWithArray:self.array copyItems:NO];
=======
                                   //handle the response
                                   //result returned
                                  
                                   //NSLog(@"res is %@", res);
                                   //NSLog(@"json is %@", json);
                                   
                                   //if successful, i can have a look inside parsedJSON - its worked as an NSdictionary and NSArray
                                   
                                   if ([json objectForKey:@"error"]==nil ) {
                                       self.nsjson=json;
>>>>>>> FETCH_HEAD
                                       //success
                                   } else {
                                       //error
                                       UIAlertView * alertView = [[UIAlertView alloc] initWithTitle: @"My Error" message: [json objectForKey:@"error"] delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
                                       [alertView show];
                                   }
                                   if (self.refreshControl.isRefreshing) {
                                       [self.refreshControl endRefreshing];
                                       self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"Pull to refresh"];
                                   }
                                   [self.tableView reloadData];
                               }];
    
}

<<<<<<< HEAD
- (void)refreshTableView:(UIRefreshControl *)controller
=======
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
>>>>>>> FETCH_HEAD
{
    if (controller.refreshing) {
        controller.attributedTitle = [[NSAttributedString alloc]initWithString:@"Loading..."];
        [self showTradeList];
    }
    
}

#pragma mark - Table view data source

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"self.have contains[c] %@", searchText];
    self.searchresult = [self.array filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    NSLog(@"imcalled");
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(tableView == self.searchDisplayController.searchResultsTableView){
        NSLog(@"!!!!%lu",[self.searchresult count]);
        return [self.searchresult count];
    }
    
    return [self.array count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
<<<<<<< HEAD
    TradeItemTableViewCell *cell = (TradeItemTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:@"TradeItemTableViewCell"];
    
    NSDictionary *tempDictionary = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        tempDictionary = [self.searchresult objectAtIndex:indexPath.row];
    } else {
        tempDictionary = [self.array objectAtIndex:indexPath.row];
    }
=======
       TradeItemTableViewCell *cell = (TradeItemTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TradeItemTableViewCell"];
 
   
               //NSLog(@"%d",[indexPath row]);
    NSDictionary *tempDictionary= [[self.nsjson objectForKey:@"result"]objectAtIndex:indexPath.row];
>>>>>>> FETCH_HEAD
    
    NSString* fontName = @"Optima-Italic";
    NSString* boldFontName = @"Optima-ExtraBlack";
    
    UIColor* mainColor = [UIColor colorWithRed:50.0/255 green:102.0/255 blue:147.0/255 alpha:1.0f];
    cell.exchangeLabel.textColor =  mainColor;
    cell.exchangeLabel.font =  [UIFont fontWithName:fontName size:14.0f];
    
    cell.haveLabel.textColor =  mainColor;
    cell.haveLabel.font =  [UIFont fontWithName:fontName size:14.0f];
<<<<<<< HEAD
    
    if([[tempDictionary objectForKey:@"have"] isEqualToString:@""]){
        cell.haveLabel.text =[NSString stringWithFormat:@"%@ have nothing",[tempDictionary objectForKey:@"username"]];
=======

    if([[tempDictionary objectForKey:@"have"] isEqualToString:@""]){
       cell.haveLabel.text =[NSString stringWithFormat:@"%@ have nothing",[tempDictionary objectForKey:@"username"]];
>>>>>>> FETCH_HEAD
    }else{
        cell.haveLabel.text =[NSString stringWithFormat:@"%@ have %@",[tempDictionary objectForKey:@"username"],[tempDictionary objectForKey:@"have"]];
        
    }
    if([[tempDictionary objectForKey:@"exchange" ] isEqualToString:@""]){
        cell.exchangeLabel.text =[NSString stringWithFormat:@" to trade nothing"];
    }else{
<<<<<<< HEAD
        cell.exchangeLabel.text =[NSString stringWithFormat:@" to trade %@",[tempDictionary objectForKey:@"exchange"]];
=======
       cell.exchangeLabel.text =[NSString stringWithFormat:@" to trade %@",[tempDictionary objectForKey:@"exchange"]];
>>>>>>> FETCH_HEAD
    }
    NSString *photoURL1 = @"http://www.mingshengxu.com/promos/img/";
    NSString *photoURL = [NSString stringWithFormat:@"%@%@_profile.jpg",photoURL1,[tempDictionary objectForKey:@"username"]];
    
    [cell.profileImageView setImageWithURL:[NSURL URLWithString:photoURL] ];
    cell.accessoryType =   UITableViewCellAccessoryDisclosureIndicator;
<<<<<<< HEAD
=======
    // Configure the cell...
>>>>>>> FETCH_HEAD
    
    return cell;
}

<<<<<<< HEAD
- (IBAction)addTradeItem_Press:(UIBarButtonItem *)sender {
    
    [self performSegueWithIdentifier:@"TradeListToAddItem" sender:self];
}
=======

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
>>>>>>> FETCH_HEAD

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
<<<<<<< HEAD
        TradeItemDetailTableViewController *transferViewController = segue.destinationViewController;
        transferViewController.tempDictionary =[[self.nsjson objectForKey:@"result"] objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        
    }
=======
         TradeItemDetailTableViewController *transferViewController = segue.destinationViewController;
       transferViewController.tempDictionary =[[self.nsjson objectForKey:@"result"] objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        
        }
>>>>>>> FETCH_HEAD
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"TradeListToAddItem"])
    {
        TradeItemDetailTableViewController *transferViewController = segue.destinationViewController;
<<<<<<< HEAD
    }
    
}


=======
       
    }

}


>>>>>>> FETCH_HEAD
@end
