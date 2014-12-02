//
//  MNBFirstViewController.m
//  MusicNetBand
//
//  Created by Debjit Saha on 4/2/14.
//  Copyright (c) 2014 RIT. All rights reserved.
//

#import "MNBFirstViewController.h"
#import "AFNetworking.h"
#import "MNBApiCreds.h"

@interface MNBFirstViewController ()
@property int first;
@property int last;
@property (strong, nonatomic) NSTimer *cdTimer;
@property (strong, nonatomic) NSTimer *nxtCdTimer;
@end

@implementation MNBFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //NSLog(@"MSIC ID - %@", _musicId);

    if ([_musicId isEqualToString:@"1"]) {
        [_musicImage setImage:[UIImage imageNamed:@"violin.png"]];
        //[_uLabel1 setText:@"You"];
    } else if ([_musicId isEqualToString:@"2"]) {
        [_musicImage setImage:[UIImage imageNamed:@"violin.png"]];
        //[_uLabel2 setText:@"You"];
    } else if ([_musicId isEqualToString:@"3"]) {
        [_musicImage setImage:[UIImage imageNamed:@"viola.png"]];
        //[_uLabel3 setText:@"You"];
    } else if ([_musicId isEqualToString:@"4"]) {
        [_musicImage setImage:[UIImage imageNamed:@"cello.png"]];
        //[_uLabel4 setText:@"You"];
    } else if ([_musicId isEqualToString:@"5"]) {
        [_musicImage setImage:[UIImage imageNamed:@"ukulele.png"]];
        //[_uLabel5 setText:@"You"];
    } else if ([_musicId isEqualToString:@"6"]) {
        [_musicImage setImage:[UIImage imageNamed:@"vibes.png"]];
        //[_uLabel6 setText:@"You"];
    }
    
    //Set rounded corners
    _musicCellno.layer.cornerRadius = 5;
    _musicCellno.layer.masksToBounds = YES;
    _musicImageview.layer.cornerRadius = 5;
    _musicImageview.layer.masksToBounds = YES;
    _musicVoteview.layer.cornerRadius = 5;
    _musicVoteview.layer.masksToBounds = YES;
    _musicImageInstr.layer.cornerRadius = 5;
    _musicImageInstr.layer.masksToBounds = YES;
    
    _audienceVoteTime = 10;
    _audienceVoteCurrentTime = 0;
    
    _cellEnterTime = (arc4random() % 4) + (arc4random() % 4) + 1 ;
    _cellEnterCurrentTime = 0;
    
    _trackedCell = 0;
    
    _cell0.backgroundColor = [UIColor greenColor];
    
    //_audienceVoteTime = 10;
}

- (UIColor*)getColor {
    return [UIColor colorWithRed:(70.0/255.0) green:(164.0/255.0) blue:(204.0/255.0) alpha:1];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_musicianIdentifierLabel setText:_musicName];
    
    [self audienceCountdown];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)audienceCountdown {
    
    _countdownLabel.text = @"Audience Voting";
    _countdownTiming.text = @"";
    
    _cdTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateMusicianData) userInfo:nil repeats:YES];
    
}

- (void)updateMusicianData {
    
    //_countdownTiming.text = @"3";
    
    if (_audienceVoteCurrentTime < _audienceVoteTime) {
        _audienceVoteCurrentTime++;
        _countdownTiming.text = [NSString stringWithFormat:@"%d", _audienceVoteTime-_audienceVoteCurrentTime];
    } else if (_audienceVoteCurrentTime == _audienceVoteTime) {
        _audienceVoteCurrentTime = 0;
        //_countdownTiming.text = [NSString stringWithFormat:@"%d", _audienceVoteTime-_audienceVoteCurrentTime];
        
        [_cdTimer invalidate];
        
        [self nextCellCountdown];
        
    }
}

- (void) nextCellCountdown {
   
    _countdownLabel.text = @"Enter Next Cell in...";
    _countdownTiming.text = @"";
    
    _cellEnterTime = (arc4random() % 4) + (arc4random() % 4) + 1 ;
    
    _nxtCdTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateMusicianDataCell) userInfo:nil repeats:YES];
    
    _trackedCell++;
    
}

- (void)updateMusicianDataCell {
    
    if (_cellEnterCurrentTime < _cellEnterTime) {
        _cellEnterCurrentTime++;
        _countdownTiming.text = [NSString stringWithFormat:@"%d", _cellEnterTime-_cellEnterCurrentTime];
    } else if (_cellEnterCurrentTime == _cellEnterTime) {
        _cellEnterCurrentTime = 0;
        //_countdownTiming.text = [NSString stringWithFormat:@"%d", _cellEnterTime-_cellEnterCurrentTime];
        
        [_nxtCdTimer invalidate];
        
        _countdownLabel.text = @"Enter Cell";
        
        _countdownTiming.text = [NSString stringWithFormat:@"%d", _trackedCell];
        
        [self cellHighlight];
        
        if (_trackedCell > 6) {
            _countdownLabel.text = @"";
            _countdownTiming.text = @"2nd Half";
        }
        
        if (_trackedCell <= 6) {
            [self performSelector:@selector(audienceCountdown) withObject:nil afterDelay:3];
        }
        
    }
}

-(void) cellHighlight {
    NSLog(@"%d", _trackedCell);
    switch (_trackedCell) {
        case 1:
            _cell1.backgroundColor = [UIColor greenColor];
            break;
        case 2:
            _cell2.backgroundColor = [UIColor greenColor];
            break;
        case 3:
            _cell3.backgroundColor = [UIColor greenColor];
            break;
        case 4:
            _cell4.backgroundColor = [UIColor greenColor];
            break;
        case 5:
            _cell5.backgroundColor = [UIColor greenColor];
            break;
        case 6:
            _cell6.backgroundColor = [UIColor greenColor];
            break;
            
        default:
            [_cdTimer invalidate];
            [_nxtCdTimer invalidate];
            _celld.backgroundColor = [UIColor greenColor];
            break;
    }
}

- (void)showCells {
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kMNapiUrl]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *parameters = @{@"musicianId": [NSNumber numberWithInt:[_musicId intValue] ]};
    AFHTTPRequestOperation *op = [manager POST:@"getCell" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);

        NSLog(@"%@", responseObject[@"1"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@ ***** %@", operation.responseString, error);
        //UIAlertView *alertViewE = [[UIAlertView alloc] initWithTitle:@"Response" message:operation.responseString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //[alertViewE show];
    }];
    [op start];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"%lu", (unsigned long)[_musicianQuestions count]);
    return [_musicianQuestions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    //NSLog(@"%@", @"jjj");
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [_musicianQuestions objectAtIndex:indexPath.row];
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //NSLog(@"%@",[_musicianQuestions objectAtIndex:indexPath.row]);
    
    //[_questionIndicator startAnimating];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kMNapiUrl]];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    
    NSDictionary *parameters = @{@"newQuestion": [_musicianQuestions objectAtIndex:indexPath.row], @"musicianId": [NSNumber numberWithInt:[_musicId intValue] ]};
    AFHTTPRequestOperation *op = [manager POST:@"setNewQuestion" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
        //[_questionIndicator stopAnimating];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Question Has Been Added" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        //UIAlertView *alertViewE = [[UIAlertView alloc] initWithTitle:@"Response" message:operation.responseString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //[alertViewE show];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@ ***** %@", operation.responseString, error);
        //[_questionIndicator stopAnimating];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Cannot Add Question" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        //UIAlertView *alertViewE = [[UIAlertView alloc] initWithTitle:@"Response" message:operation.responseString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //[alertViewE show];
        
    }];
    
    [op start];
    
}

@end
