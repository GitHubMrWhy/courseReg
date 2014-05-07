//
//  TradeItemDetailTableViewController.h
//  courseReg
//
//  Created by Mingsheng Xu on 9/29/13.
//  Copyright (c) 2013 Mingsheng Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TradeItemDetailTableViewController : UITableViewController


@property (strong, nonatomic)          NSString *crn;
@property (strong, nonatomic)          NSString *userPost;
@property (strong, nonatomic)          NSString *courseNum;
@property (strong, nonatomic) IBOutlet UITableViewCell *courseNum_Cell;
@property (strong, nonatomic) IBOutlet UITableViewCell *crn_cell;



@end
