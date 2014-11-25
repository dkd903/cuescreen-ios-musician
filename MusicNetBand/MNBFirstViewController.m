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
@end

@implementation MNBFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //NSLog(@"MSIC ID - %@", _musicId);

    if ([_musicId isEqualToString:@"1"]) {
        [_musicImage setImage:[UIImage imageNamed:@"violin.png"]];
        _musicianLabel1.textColor = [self getColor];
        _voteLabel1.textColor = [self getColor];
        //[_uLabel1 setText:@"You"];
    } else if ([_musicId isEqualToString:@"2"]) {
        [_musicImage setImage:[UIImage imageNamed:@"violin.png"]];
        _musicianLabel2.textColor = [self getColor];
        _voteLabel2.textColor = [self getColor];
        //[_uLabel2 setText:@"You"];
    } else if ([_musicId isEqualToString:@"3"]) {
        [_musicImage setImage:[UIImage imageNamed:@"viola.png"]];
        _musicianLabel3.textColor = [self getColor];
        _voteLabel3.textColor = [self getColor];
        //[_uLabel3 setText:@"You"];
    } else if ([_musicId isEqualToString:@"4"]) {
        [_musicImage setImage:[UIImage imageNamed:@"cello.png"]];
        _musicianLabel4.textColor = [self getColor];
        _voteLabel4.textColor = [self getColor];
        //[_uLabel4 setText:@"You"];
    } else if ([_musicId isEqualToString:@"5"]) {
        [_musicImage setImage:[UIImage imageNamed:@"ukulele.png"]];
        _musicianLabel5.textColor = [self getColor];
        _voteLabel5.textColor = [self getColor];
        //[_uLabel5 setText:@"You"];
    } else if ([_musicId isEqualToString:@"6"]) {
        [_musicImage setImage:[UIImage imageNamed:@"vibes.png"]];
        _musicianLabel6.textColor = [self getColor];
        _voteLabel6.textColor = [self getColor];
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
}

- (UIColor*)getColor {
    return [UIColor colorWithRed:(70.0/255.0) green:(164.0/255.0) blue:(204.0/255.0) alpha:1];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_musicianIdentifierLabel setText:_musicName];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateMusicianData) userInfo:nil repeats:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextClick:(id)sender {
    [_nextCellIndicator startAnimating];
    //NSLog(@"ggg %@", _musicId);
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kMNapiUrl]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *parameters = @{@"musicianId": [NSNumber numberWithInt:[_musicId intValue] ]};
    AFHTTPRequestOperation *op = [manager POST:@"toNextCell" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
        [_nextCellIndicator stopAnimating];
        //UIAlertView *alertViewE = [[UIAlertView alloc] initWithTitle:@"Response" message:operation.responseString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //[alertViewE show];
        [_cellLabel setText:[responseObject[@"cellNumber"] stringValue]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@ ***** %@", operation.responseString, error);
        [_nextCellIndicator stopAnimating];
        UIAlertView *alertViewE = [[UIAlertView alloc] initWithTitle:@"Response" message:operation.responseString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //[alertViewE show];
    }];
    [op start];
}

- (void)updateMusicianData {
    [self showVotes];
    
    [self updateCurrentCell];
    //[self showCells];
}

- (void)showVotes {
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kMNapiUrl]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *parameters = @{@"musicianId": [NSNumber numberWithInt:[_musicId intValue] ]};
    AFHTTPRequestOperation *op = [manager POST:@"getAllVotes" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
        [_voteLabel1 setText:responseObject[@"1"]];
        [_voteLabel2 setText:responseObject[@"2"]];
        [_voteLabel3 setText:responseObject[@"3"]];
        [_voteLabel4 setText:responseObject[@"4"]];
        [_voteLabel5 setText:responseObject[@"5"]];
        [_voteLabel6 setText:responseObject[@"6"]];
        //NSLog(@"%@", responseObject[@"1"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@ ***** %@", operation.responseString, error);
        //UIAlertView *alertViewE = [[UIAlertView alloc] initWithTitle:@"Response" message:operation.responseString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //[alertViewE show];
    }];
    [op start];
}

- (void)showCells {
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kMNapiUrl]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *parameters = @{@"musicianId": [NSNumber numberWithInt:[_musicId intValue] ]};
    AFHTTPRequestOperation *op = [manager POST:@"getCell" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
        [_cellLabel1 setText:responseObject[@"0"]];
        [_cellLabel2 setText:responseObject[@"1"]];
        [_cellLabel3 setText:responseObject[@"2"]];
        [_cellLabel4 setText:responseObject[@"3"]];
        [_cellLabel5 setText:responseObject[@"4"]];
        [_cellLabel6 setText:responseObject[@"5"]];
        NSLog(@"%@", responseObject[@"1"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@ ***** %@", operation.responseString, error);
        //UIAlertView *alertViewE = [[UIAlertView alloc] initWithTitle:@"Response" message:operation.responseString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //[alertViewE show];
    }];
    [op start];
}

- (void)updateCurrentCell {
    //[_nextCellIndicator startAnimating];
    //NSLog(@"ggg %@", _musicId);
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kMNapiUrl]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *parameters = @{@"musicianId": [NSNumber numberWithInt:[_musicId intValue] ]};
    AFHTTPRequestOperation *op = [manager POST:@"getCurrentCell" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
        [_nextCellIndicator stopAnimating];
        //UIAlertView *alertViewE = [[UIAlertView alloc] initWithTitle:@"Response" message:operation.responseString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //[alertViewE show];
        [_cellLabel setText:[responseObject[@"cellNumber"] stringValue]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@ ***** %@", operation.responseString, error);
        //[_nextCellIndicator stopAnimating];
        UIAlertView *alertViewE = [[UIAlertView alloc] initWithTitle:@"Response" message:operation.responseString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
