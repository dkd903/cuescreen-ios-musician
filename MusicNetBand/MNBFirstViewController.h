//
//  MNBFirstViewController.h
//  MusicNetBand
//
//  Created by Debjit Saha on 4/2/14.
//  Copyright (c) 2014 RIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MNBFirstViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;
@property (weak, nonatomic) IBOutlet UILabel *countdownTiming;
@property (strong, nonatomic) NSString *musicId;
@property (strong, nonatomic) NSString *musicName;
@property (strong, nonatomic) NSNumber *audienceVoteTime;
@property (strong, nonatomic) NSNumber *cueStartsInTime;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *nextCellIndicator;
@property (weak, nonatomic) IBOutlet UILabel *musicianIdentifierLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;
@property NSArray *musicianQuestions;
- (IBAction)nextClick:(id)sender;
- (UIColor*)getColor;
@property (weak, nonatomic) IBOutlet UIImageView *musicImage;
@property (weak, nonatomic) IBOutlet UIView *musicCellno;
@property (weak, nonatomic) IBOutlet UIView *musicImageview;
@property (weak, nonatomic) IBOutlet UIView *musicVoteview;
@property (weak, nonatomic) IBOutlet UIImageView *musicImageInstr;
@property (weak, nonatomic) IBOutlet UILabel *voteLabel1;
@property (weak, nonatomic) IBOutlet UILabel *voteLabel2;
@property (weak, nonatomic) IBOutlet UILabel *voteLabel3;
@property (weak, nonatomic) IBOutlet UILabel *voteLabel4;
@property (weak, nonatomic) IBOutlet UILabel *voteLabel5;
@property (weak, nonatomic) IBOutlet UILabel *voteLabel6;
@property (weak, nonatomic) IBOutlet UILabel *musicianLabel1;
@property (weak, nonatomic) IBOutlet UILabel *musicianLabel2;
@property (weak, nonatomic) IBOutlet UILabel *musicianLabel3;
@property (weak, nonatomic) IBOutlet UILabel *musicianLabel4;
@property (weak, nonatomic) IBOutlet UILabel *musicianLabel5;
@property (weak, nonatomic) IBOutlet UILabel *musicianLabel6;
@property (weak, nonatomic) IBOutlet UILabel *uLabel1;
@property (weak, nonatomic) IBOutlet UILabel *uLabel2;
@property (weak, nonatomic) IBOutlet UILabel *uLabel3;
@property (weak, nonatomic) IBOutlet UILabel *uLabel4;
@property (weak, nonatomic) IBOutlet UILabel *uLabel5;
@property (weak, nonatomic) IBOutlet UILabel *uLabel6;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel1;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel2;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel3;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel4;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel5;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel6;
- (void)showVotes;
- (void)showCells;
@end
