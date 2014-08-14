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
    
    double bill = 0.0;
    double tip = 0.0;
    int split = 0;
    double total = 0.0;
    
    bill = [enteredBill.text doubleValue];
    tip = [tipField.text doubleValue];
    split = [splitField.text intValue];
    
    total = ((bill * (tip/100) + bill) / split);
    
    totalLabel.text = [NSString stringWithFormat:@"%i people at $%.2f per person", split, total];
    totalLabel.numberOfLines = 2;
    
    
    
}

-(void) removeNumberPad {
    
    [enteredBill resignFirstResponder];
    [splitField resignFirstResponder];
    [tipField resignFirstResponder];
}

@end
