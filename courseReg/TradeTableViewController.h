//
//  TradeTableViewController.h
//  courseReg
//
//  Created by Mingsheng Xu on 9/22/13.
//  Copyright (c) 2013 Mingsheng Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TradeTableViewController :  UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *searchresult;
@property(strong,nonatomic)NSDictionary *nsjson;
@property(strong,nonatomic)NSMutableArray *array;

@property(strong,nonatomic)NSDictionary* passInfo;

<<<<<<< HEAD
=======
<<<<<<< HEAD
<<<<<<< HEAD
=======
=======
>>>>>>> FETCH_HEAD
@property(strong,nonatomic)NSDictionary* passInfo;


>>>>>>> FETCH_HEAD
<<<<<<< HEAD
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
- (IBAction)addTradeItem_Press:(id)sender;

@end
