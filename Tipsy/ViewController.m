//
//  ViewController.m
//  Tipsy
//
//  Created by Rakshit Garg on 6/15/14.
//  Copyright (c) 2014 Gargium Interactive. All rights reserved.
//

// FOR FUTURE VERSIONS: Add a "save location" functionality and a settings bar to set certain defaults.

#import "ViewController.h"

//  Necessary import to use the Facebook and Twitter features
#import <Social/Social.h>

@interface ViewController ()
@end

@implementation ViewController

//  synthesis of properties that were declared in ViewController.h file
@synthesize enteredBill, tipField, splitField, totalLabel;
@synthesize tipAmountField, totalBillAmount;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//  Calls the removeNumberPad method when the user taps out of the keyboard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeNumberPad)];
    [self.view addGestureRecognizer:tap];
   
//  add background image to view
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

//  Action that is triggered when "Calculate" button is pressed
-(IBAction)calculateBill:(id)sender {

//  Call to removeNumberPad, allowing keyboard to exit when the user presses the calculate button
//  This allows the user to actually see the tip, rather than just the keyboard
    [self removeNumberPad];

//  Initialization of variables
    double bill = 0.0;  //  The after-tax total
    double tip = 0.0;   //  Amount that the user wants to tip (in %)
    int split = 0;  //  Number of people user will split the bill with (including user)
    double total = 0.0; // Total cost
    
//  Retrieves values in double format from the textFields
    bill = [enteredBill.text doubleValue];
    tip = [tipField.text doubleValue];
    split = [splitField.text intValue];
    
//  Error handling logic, just in case the user accidentally types in 0 for the "Split" field
    if (split <= 0) {
        
//  Creates a popup alert, notifying user to type in a positive integer for Split
        UIAlertView *errorMessage = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Split must be a positive integer!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorMessage show];
        //[errorMessage release];
    }
    
    total = ((bill * (tip/100) + bill) / split);
    
    totalLabel.text = [NSString stringWithFormat:@"$%.2f each", total];
    totalLabel.numberOfLines = 1;
    
    tipAmountField.text = [NSString stringWithFormat:@"$%.2f", tip * bill * .01];
    totalBillAmount.text = [NSString stringWithFormat:@"$%.2f", (tip * bill * .01) + bill];
    
}

//  Posts to twitter

- (IBAction)postToTwitter:(id)sender {
    
//  Checking if Twitter account is available on device
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        mySLComposerSheet = [[SLComposeViewController alloc] init]; // Initiate Social Controller
        mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter]; //Specify that we want Twitter,
//  not an alternate Social Network
        
        [mySLComposerSheet setInitialText:[NSString stringWithFormat:@"Had a great time eating at (insert venue here)!", mySLComposerSheet.serviceType]]; //Default text that will show up in the box
        
        [self presentViewController:mySLComposerSheet animated:YES completion:nil];
    }
    
    [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        NSString *output;
       
//  BASIC ERROR MANAGEMENT:
//  Returns a popup alert notifying the user whether the post was successful or if the action was cancelled
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                output = @"Action Cancelled";
                break;
            case SLComposeViewControllerResultDone:
                output = @"Post Successful";
            default:
                break;
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter" message:output delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];
    
}


- (IBAction)postToFacebook:(id)sender {

    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        mySLComposerSheet = [[SLComposeViewController alloc] init];
        mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [mySLComposerSheet setInitialText:[NSString stringWithFormat:@"Had a great time eating at (insert venue here)!", mySLComposerSheet.serviceType]];
        [self presentViewController:mySLComposerSheet animated:YES completion:nil];
    }
    
    [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        NSString *output;
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                output = @"Action Cancelled";
                break;
            case SLComposeViewControllerResultDone:
                output = @"Post Successful";
            default:
                break;
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook" message:output delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];
    
}

//  Method that hides the keyboard

-(void) removeNumberPad {
    
    [enteredBill resignFirstResponder];
    [splitField resignFirstResponder];
    [tipField resignFirstResponder];
}

@end
