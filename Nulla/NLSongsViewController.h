//
//  NLSongsViewController.h
//  Nulla
//
//  Created by admin on 19.07.14.
//  Copyright (c) 2014 Artur Guseynov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVAudioPlayer.h>

@interface NLSongsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *songsList;
@property (strong, nonatomic) AVPlayer *audioPlayer;
@end
