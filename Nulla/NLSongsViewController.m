//
//  NLSongsViewController.m
//  Nulla
//
//  Created by admin on 19.07.14.
//  Copyright (c) 2014 Artur Guseynov. All rights reserved.
//

#import "NLSongsViewController.h"

@interface NLSongsViewController ()

@end

@implementation NLSongsViewController

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
    
	self.tableView.dataSource =self;
    self.tableView.delegate = self;
    self.AudioPlayer=[[AVPlayer alloc] init];
    
    MPMediaQuery *data=[[MPMediaQuery alloc] init];
    NSArray *ItemsFromData= [data items];
    self.songsList=[NSMutableArray arrayWithArray:ItemsFromData];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.songsList.count;
};


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MusicCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    MPMediaItem *song = [self.songsList objectAtIndex:indexPath.row];
    NSString *songTitle = [song valueForProperty: MPMediaItemPropertyTitle];
    NSString *durationLabel = [song valueForProperty: MPMediaItemPropertyArtist];
    cell.textLabel.text = songTitle;
    cell.detailTextLabel.text = durationLabel;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.audioPlayer pause];
    MPMediaItem *song = [self.songsList objectAtIndex:indexPath.row];
    AVPlayerItem * currentItem = [AVPlayerItem playerItemWithURL:[song valueForProperty:MPMediaItemPropertyAssetURL]];
    
    [self.audioPlayer replaceCurrentItemWithPlayerItem:currentItem];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
