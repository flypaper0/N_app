//
//  MySingleton.m
//  Nulla
//
//  Created by admin on 31.07.14.
//  Copyright (c) 2014 Artur Guseynov. All rights reserved.
//

#import "MySingleton.h"
static MySingleton *sharedInstance = nil;
@interface MySingleton (){
}
@end
@implementation MySingleton
@synthesize singleAudioPlayer;
//Инициализация синглтона
-(id)init{
    if(self=[super init]){
        
    }
    return self;
}
+(MySingleton *) sharedInstance
{

        if (sharedInstance==nil)
        {
            sharedInstance=[[[self class]alloc]init];
        }

    return sharedInstance;
}
//Запуск проигрывателя с переданным ему итемом
-(void)playWithItem:(AVPlayerItem*) playerItem{
    singleAudioPlayer=[[AVPlayer alloc] initWithPlayerItem:playerItem];
    [singleAudioPlayer play];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
}
//Длина текущей песни
-(CMTime)currentTrackLenght{
    return singleAudioPlayer.currentItem.asset.duration;
}
//текущее время песни
-(CMTime)currentTrakTime{
    return singleAudioPlayer.currentTime;
}
//Играть
-(void) play{
    [singleAudioPlayer play];
}
//Пауза
-(void)pause{
    [singleAudioPlayer pause];
}
//Перейти к
-(void)seekToTIme:(float)currentSliderPossition{
     [singleAudioPlayer seekToTime:CMTimeMakeWithSeconds(currentSliderPossition,1)];
}
@end
					