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

@property int audienceVoteTime;
@property int audienceVoteCurrentTime;

@property int cellEnterTime;
@property int cellEnterCurrentTime;

@property int trackedCell;

@property (strong, nonatomic) NSNumber *cueStartsInTime;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *nextCellIndicator;
@property (weak, nonatomic) IBOutlet UILabel *musicianIdentifierLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;

@property NSArray *musicianQuestions;

- (UIColor*)getColor;

@property (weak, nonatomic) IBOutlet UIImageView *musicImage;
@property (weak, nonatomic) IBOutlet UIView *musicCellno;
@property (weak, nonatomic) IBOutlet UIView *musicImageview;
@property (weak, nonatomic) IBOutlet UIView *musicVoteview;
@property (weak, nonatomic) IBOutlet UIImageView *musicImageInstr;

- (void)showVotes;
- (void)showCells;


@property (weak, nonatomic) IBOutlet UILabel *cell0;
@property (weak, nonatomic) IBOutlet UILabel *cell1;
@property (weak, nonatomic) IBOutlet UILabel *cell2;
@property (weak, nonatomic) IBOutlet UILabel *cell3;
@property (weak, nonatomic) IBOutlet UILabel *cell4;
@property (weak, nonatomic) IBOutlet UILabel *cell5;
@property (weak, nonatomic) IBOutlet UILabel *cell6;
@property (weak, nonatomic) IBOutlet UILabel *celld;

@end
