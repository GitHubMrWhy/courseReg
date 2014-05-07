//
//  TradeTableViewController.h
//  courseReg
//
//  Created by Mingsheng Xu on 9/22/13.
//  Copyright (c) 2013 Mingsheng Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TradeTableViewController : UITableViewController


@property (strong, nonatomic) NSMutableArray *listData;
@property(strong,nonatomic)NSDictionary *nsjson;
@property(strong,nonatomic)NSArray *array;

@property(strong,nonatomic)NSDictionary* passInfo;


- (IBAction)addTradeItem_Press:(id)sender;

@end
