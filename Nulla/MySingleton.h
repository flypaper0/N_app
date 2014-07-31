//
//  MySingleton.h
//  Nulla
//
//  Created by admin on 31.07.14.
//  Copyright (c) 2014 Artur Guseynov. All rights reserved.
//Это синглтон. Про него можно почитать в гугле - кратко, эта хрень позволяет работать только одному потоку

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface MySingleton : NSObject{
    
}
@property (strong, nonatomic) AVPlayer *singleAudioPlayer;
//Здесь все функции, чтобы использовать в других местах
+ (MySingleton *) sharedInstance;
-(void)playWithItem:(AVPlayerItem*) playerItem;
-(CMTime)currentTrackLenght;
-(CMTime)currentTrakTime;
-(void) play;
-(void) pause;
-(void)seekToTIme:(float)currentSliderPossition;
@end
