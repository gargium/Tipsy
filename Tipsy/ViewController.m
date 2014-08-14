//
//  ViewController.m
//  Tipsy
//
//  Created by Gargium on 6/15/14.
//  Copyright (c) 2014 Gargium Interactive. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize enteredBill, tipField, splitField, totalLabel;
@synthesize tipAmountField, totalBillAmount;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeNumberPad)];
    [self.view addGestureRecognizer:tap];
   
    //add background image to view
    UIImage *backgroundImageGold = [UIImage imageNamed:@"TipsyBG.png"];
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    backgroundImageView.image = backgroundImageGold;
    [self.view insertSubview:backgroundImageView atIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)calculateBill:(id)sender {
    
    [self removeNumberPad];
    
    double bill = 0.0;
    double tip = 0.0;
    int split = 0;
    double total = 0.0;
    
    bill = [enteredBill.text doubleValue];
    tip = [tipField.text doubleValue];
    split = [splitField.text intValue];
    
    total = ((bill * (tip/100) + bill) / split);
    
    totalLabel.text = [NSString stringWithFormat:@"$%.2f each", total];
    totalLabel.numberOfLines = 1;
    
    tipAmountField.text = [NSString stringWithFormat:@"$%.2f", tip * bill * .01];
    totalBillAmount.text = [NSString stringWithFormat:@"$%.2f", (tip * bill * .01) + bill];
    
    
    
}

-(void) removeNumberPad {
    
    [enteredBill resignFirstResponder];
    [splitField resignFirstResponder];
    [tipField resignFirstResponder];
}

@end
