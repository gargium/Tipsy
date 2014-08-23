//
//  ViewController.h
//  Tipsy
//
//  Created by Rakshit Garg on 6/15/14.
//  Copyright (c) 2014 Gargium Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>

@interface ViewController : UIViewController {
    
//    create new slcomposeviewcontroller to handle the facebook
//    and twitter requests in the .m file
    
    SLComposeViewController *mySLComposerSheet;
}

//  declare properties for the UILabels
@property (weak, nonatomic) IBOutlet UILabel *tipAmountField;
@property (weak, nonatomic) IBOutlet UILabel *totalBillAmount;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

// declare properties for the UITextFields (which is where user will be entering data)
@property (weak, nonatomic) IBOutlet UITextField *enteredBill;
@property (weak, nonatomic) IBOutlet UITextField *tipField;
@property (weak, nonatomic) IBOutlet UITextField *splitField;

//  declare property for UIButton, which will be used to calculate tip
@property (weak, nonatomic) IBOutlet UIButton *calculateBill;


//  declare actions that will be implemented in the .m file
- (IBAction)calculateBill:(id)sender;
- (IBAction)postToTwitter:(id)sender;
- (IBAction)postToFacebook:(id)sender;

-(void) setLabelDefaults;
-(BOOL) prefersStatusBarHidden;


@end
