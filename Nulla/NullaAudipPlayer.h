//
//  NullaAudipPlayer.h
//  Nulla
//
//  Created by admin on 29.07.14.
//  Copyright (c) 2014 Artur Guseynov. All rights reserved.

//Меню аудио плеера

#import <UIKit/UIKit.h>
#import "AutoScrollLabel.h"
#import "BeamMusicPlayerTransparentToolbar.h"
#import "OBSlider.h"
#import "MySingleton.h"
#import "TDAudioStreamer.h"
#import "TDSession.h"
#import "NLMediaViewController.h"
#import "SearchViewController.h"
@import MediaPlayer;
@import MultipeerConnectivity;
@import AVFoundation;


@interface NullaAudipPlayer : UIViewController
@property (nonatomic) NSInteger currentTrack;//текущий трек
@property (strong,nonatomic) MPMediaItem *song;//я думаю, это песня
@property (strong,nonatomic) NSArray *dataGot;//все песни
@property (nonatomic,readwrite) int numberOfSong;//номер песни
@property (nonatomic,strong) MPMusicPlayerController* musicPlayer;//Не использовал, но пусть полежит
@property (nonatomic) BOOL playing;//Булен играет/не играет
@property (strong, nonatomic) IBOutlet UIImageView *albumArtImageView;//можно и догадаться
@property (strong, nonatomic) IBOutlet UISwitch *visibleSwitcher;
@property (strong, nonatomic) NSString *deviceName;

//Текущая позиция песни
@property (nonatomic) CGFloat currentPlaybackPosition;
//функции, они там, внутри
-(void)updateUIForCurrentTrack;
-(void)play;

-(void)pause;


-(void)stop;


-(void)next;


-(void)previous;


-(void)changeTrack:(NSInteger)newTrack;


@end
