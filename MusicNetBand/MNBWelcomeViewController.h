//
//  MNBWelcomeViewController.h
//  MusicNetBand
//
//  Created by Debjit Saha on 4/17/14.
//  Copyright (c) 2014 RIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MNBWelcomeViewController : UIViewController
- (IBAction)continueButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *musicWelcome;
@property NSArray *musicianNames;
@property NSString *musicianMainId;
@property NSString *musicianMainName;
@end
