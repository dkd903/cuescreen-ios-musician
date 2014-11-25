//
//  MNBWelcomeViewController.m
//  MusicNetBand
//
//  Created by Debjit Saha on 4/17/14.
//  Copyright (c) 2014 RIT. All rights reserved.
//

#import "MNBWelcomeViewController.h"
#import "MNBFirstViewController.h"
#import "MNBApiCreds.h"
#import "AFNetworking.h"
#import <QuartzCore/QuartzCore.h>

@interface MNBWelcomeViewController ()

@end

@implementation MNBWelcomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _musicianMainName = @"";
    _musicianMainId = @"";
    // Do any additional setup after loading the view.
    _musicianNames = [NSArray arrayWithObjects:@"Violin 1",
                      @"Violin 2",
                      @"Viola",
                      @"Cello",
                      @"Ukulele",
                      @"Vibes", nil];
    _musicWelcome.layer.cornerRadius = 5;
    _musicWelcome.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    MNBFirstViewController *targetVC = (MNBFirstViewController*)segue.destinationViewController;
    targetVC.musicId = _musicianMainId;
    targetVC.musicName = _musicianMainName;
}

#pragma mark - Sender

- (IBAction)continueButton:(id)sender {
    if ([_musicianMainName length] == 0) {
        UIAlertView *alertViewE = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please Enter Musician's ID" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertViewE show];
    } else {
        [self performSegueWithIdentifier:@"SegueToMain" sender:self];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%lu", (unsigned long)[_musicianNames count]);
    return [_musicianNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    //NSLog(@"%@", @"jjj");
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [_musicianNames objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    //cell.textLabel.numberOfLines = 2;
    //cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    _musicianMainId = [NSString stringWithFormat:@"%d",(int)indexPath.row+1 ];
    _musicianMainName = [_musicianNames objectAtIndex:indexPath.row];
    //NSLog(@"%@",[_musicianNames objectAtIndex:indexPath.row]);
    
}
@end
