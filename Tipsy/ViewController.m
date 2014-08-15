//
//  ViewController.m
//  Tipsy
//
//  Created by Gargium on 6/15/14.
//  Copyright (c) 2014 Gargium Interactive. All rights reserved.
//

// FOR FUTURE VERSIONS: Add a "save location" functionality and a settings bar to set certain defaults.

#import "ViewController.h"
#import <Social/Social.h>

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
    
    if (split <= 0) {
        
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

- (IBAction)postToTwitter:(id)sender {
//        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
//        
//        SLComposeViewController *tweeter = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
//        [tweeter setInitialText:@"Had a great time eating at (insert location here)!"];
//        [self presentViewController:tweeter animated:YES completion:nil];

    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        mySLComposerSheet = [[SLComposeViewController alloc] init];
        mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
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
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter" message:output delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];
    
}



//if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) //check if Facebook Account is linked
//{
//    mySLComposerSheet = [[SLComposeViewController alloc] init]; //initiate the Social Controller
//    mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook]; //Tell him with what social plattform to use it, e.g. facebook or twitter
//    [mySLComposerSheet setInitialText:[NSString stringWithFormat:@"Test",mySLComposerSheet.serviceType]]; //the message you want to post
//    [mySLComposerSheet addImage:yourimage]; //an image you could post
//    //for more instance methodes, go here:https://developer.apple.com/library/ios/#documentation/NetworkingInternet/Reference/SLComposeViewController_Class/Reference/Reference.html#//apple_ref/doc/uid/TP40012205
//    [self presentViewController:mySLComposerSheet animated:YES completion:nil];
//}
//[mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
//    NSString *output;
//    switch (result) {
//        case SLComposeViewControllerResultCancelled:
//            output = @"Action Cancelled";
//            break;
//        case SLComposeViewControllerResultDone:
//            output = @"Post Successfull";
//            break;
//        default:
//            break;
//    } //check if everything worked properly. Give out a message on the state.
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//    [alert show];
//}];


- (IBAction)postToFacebook:(id)sender {
//    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
//        SLComposeViewController *fb = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
//        [fb setInitialText:@"Had a great time eating at (instert location here)!"];
//        [self presentViewController:fb animated:YES completion:nil];
    
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







-(void) removeNumberPad {
    
    [enteredBill resignFirstResponder];
    [splitField resignFirstResponder];
    [tipField resignFirstResponder];
}

@end
