//
//  ViewController.h
//  Tipsy
//
//  Created by Gargium on 6/15/14.
//  Copyright (c) 2014 Gargium Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *tipAmountField;
@property (weak, nonatomic) IBOutlet UILabel *totalBillAmount;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@property (weak, nonatomic) IBOutlet UITextField *enteredBill;
@property (weak, nonatomic) IBOutlet UITextField *tipField;
@property (weak, nonatomic) IBOutlet UITextField *splitField;

@property (weak, nonatomic) IBOutlet UIButton *calculateBill;
- (IBAction)calculateBill:(id)sender;


@end
