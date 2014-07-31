//
//  NullaAudipPlayer.m
//  Nulla
//
//  Created by admin on 29.07.14.
//  Copyright (c) 2014 Artur Guseynov. All rights reserved.
//

#import "NullaAudipPlayer.h"

@interface NullaAudipPlayer ()
- (IBAction)previosAction:(id)sender;//Баттоны
- (IBAction)playPause:(id)sender;
- (IBAction)nextAction:(id)sender;
- (IBAction)valueChanged:(OBSlider *)sender;//Изменения ползунка слайдера
- (IBAction)startStreamButton:(id)sender;

- (IBAction)sliderDidEndScrubbing:(OBSlider *)sender;//Начало скрола и конец
- (IBAction)sliderDidBeginScrubbing:(OBSlider *)sender;


@property (strong, nonatomic) IBOutlet AutoScrollLabel *artistNameLabel;//Автоматичиски двигающийся лейбел
@property (strong, nonatomic) IBOutlet AutoScrollLabel *trackNameTitle;
@property (strong, nonatomic) IBOutlet AutoScrollLabel *albumTitle;
@property (strong, nonatomic) IBOutlet BeamMusicPlayerTransparentToolbar *controlsToolBar;//Контроол бра из другого плеер, хз зачем

@property (strong, nonatomic) IBOutlet UIBarButtonItem *playButton;//Кнопки играть, назад и вперед
@property (strong, nonatomic) IBOutlet UIBarButtonItem *rewindButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *fastForwardButton;
@property (strong, nonatomic) IBOutlet OBSlider *progressSlider;//сам слайдер
@property (nonatomic) NSInteger numberOfTracks;//количество треков. В планах на будущее
@property (nonatomic,strong) NSTimer* playbackTickTimer;//Таймер
@property(nonatomic) NSTimeInterval currentPlaybackTime;//текущее время
@property (nonatomic) CGFloat currentTrackLength; // Длина текуцщего трека

@property (nonatomic) BOOL scrobbling;//Если скрол дивжется
@property (strong, nonatomic) AVPlayerItem * currentItem;//Итем плеера
@property (nonatomic, assign) float timerInterval;//Интервал времени, забыл зачем


@end

@implementation NullaAudipPlayer
@synthesize artistNameLabel;
@synthesize trackNameTitle;
@synthesize albumTitle;
@synthesize albumArtImageView;
@synthesize controlsToolBar;
@synthesize playButton;
@synthesize rewindButton;
@synthesize fastForwardButton;
@synthesize currentItem,song;
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
    //Получаем адрес песни
    NSURL *Url1=[song valueForProperty:MPMediaItemPropertyAssetURL];
    //получаем итем для плеера
    currentItem = [AVPlayerItem playerItemWithURL:Url1];
    //В синглтоне запускаем песню
    [[MySingleton sharedInstance]playWithItem:currentItem];

    //функция где то ниже
    [self updateUIForCurrentTrack] ;
    //цвет фона. Картинки брал из другого плеера, что так сказать нашел то и взял
   self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BeamMusicPlayerController.bundle/images/black_linen_v2"]];
   //Всякая фигня с графикой
    UIImage* knob = [UIImage imageNamed:@"BeamMusicPlayerController.bundle/images/VolumeKnob"];
    [_progressSlider setThumbImage:knob forState:UIControlStateNormal];
    _progressSlider.maximumTrackTintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    UIImage* minImg = [[UIImage imageNamed:@"BeamMusicPlayerController.bundle/images/speakerSliderMinValue.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 16, 0, 16)];
    UIImage* maxImg = [[UIImage imageNamed:@"BeamMusicPlayerController.bundle/images/speakerSliderMaxValue.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 16, 0, 16)];
    [_progressSlider setMinimumTrackImage:minImg forState:UIControlStateNormal];
    [_progressSlider setMaximumTrackImage:maxImg forState:UIControlStateNormal];
    
    rewindButton.tintColor = UIColor.whiteColor;
    playButton.tintColor = UIColor.whiteColor;
    fastForwardButton.tintColor = UIColor.whiteColor;
    
    [self.artistNameLabel setShadowColor:[UIColor blackColor]];
    [self.artistNameLabel setShadowOffset:CGSizeMake(0, -1)];
    
    [self.albumTitle setShadowColor:[UIColor blackColor]];
    [self.albumTitle setShadowOffset:CGSizeMake(0, -1)];
    [self.artistNameLabel setTextColor:[UIColor lightTextColor]];
    [self.artistNameLabel setFont:[UIFont boldSystemFontOfSize:12]];
    
    [self.albumTitle setTextColor:[UIColor lightTextColor]];
    [self.albumTitle setFont:[UIFont boldSystemFontOfSize:12]];
    
    self.trackNameTitle.textColor = [UIColor blackColor];
    [self.trackNameTitle setFont:[UIFont boldSystemFontOfSize:12]];
    [self play];
 [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//Забыл зачем но нужно
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [self.albumTitle setNeedsLayout];
    [self.artistNameLabel setNeedsLayout];
    [self.trackNameTitle setNeedsLayout];
    
    
}
//Это со спертого Тулбара, ему они нужны
-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar {
    return UIBarPositionTopAttached;
}
//Забил, потом доделаю
-(BOOL)numberOfTracksAvailable {
    return self.numberOfTracks >= 0;
}

//Обновление информации о песне
-(void)updateUIForCurrentTrack {
    self.artistNameLabel.text = [song valueForProperty:MPMediaItemPropertyArtist];
    self.trackNameTitle.text = [song valueForProperty:MPMediaItemPropertyTitle];
    self.albumTitle.text = [song valueForProperty:MPMediaItemPropertyAlbumTitle];
    UIImage *albumImage=[[song valueForProperty:MPMediaItemPropertyArtwork] imageWithSize:CGSizeMake(320, 320)];
    if (albumImage !=nil) {
        
        [albumArtImageView setImage: albumImage];
     
    }
   
}
//Играть песню
-(void)play {
    //Булен, теперь мы знаем, что плеер играет
    self.playing=YES;
    //Запуск песни через синглтон
    [[MySingleton sharedInstance]play];
    //Длина песни
    _currentTrackLength=CMTimeGetSeconds([[MySingleton sharedInstance]currentTrackLenght]);
    //Максимальное значение слдайдера
    _progressSlider.maximumValue=_currentTrackLength;
    //Функции обе ниже
    [self startPlaybackTickTimer];
    
    [self adjustPlayButtonState];

}
//Таймер, хотел циферки песни выводить, но не успел
-(void)startPlaybackTickTimer {
    self.playbackTickTimer = [NSTimer scheduledTimerWithTimeInterval:self.timerInterval target:self selector:@selector(playbackTick:) userInfo:nil repeats:YES];
}
//Движение скрола по мере звучания песни, если мы сами не движем.
-(void)playbackTick:(id)unused {
    if ( !self.scrobbling ){
        [self syncPlaybackPosition];
        _currentTrackLength=CMTimeGetSeconds([[MySingleton sharedInstance]currentTrackLenght]);
        if ( self->_currentPlaybackPosition >= self.currentTrackLength ){
            [self currentTrackFinished];
        } else {
            [self updateSeekUI];
        }
    }
}
//Конец песни
-(void)currentTrackFinished {
    _numberOfSong=_numberOfSong+1;
    song=[self.dataGot objectAtIndex:_numberOfSong];
    NSURL *Url1=[song valueForProperty:MPMediaItemPropertyAssetURL];
    currentItem = [AVPlayerItem playerItemWithURL:Url1];
    [[MySingleton sharedInstance]playWithItem:currentItem];
    self.currentPlaybackPosition = 0;
    [self updateSeekUI];
}

-(void)updateSeekUI {
        self.progressSlider.value = self.currentPlaybackPosition;

       NSLog(@"progressSlider - %f", self.progressSlider.value);
}

-(void)updateUI {
    // Slider
    self.progressSlider.maximumValue = self.currentTrackLength;
    self.progressSlider.minimumValue = 0;
    
    [self updateUIForCurrentTrack];
    [self updateSeekUI];
}
- (void)syncPlaybackPosition {
    
    self.currentPlaybackPosition = CMTimeGetSeconds([[MySingleton sharedInstance]currentTrakTime]);
}

-(void)adjustPlayButtonState {
    if ( !self.playing ){
        self.playButton.image = [UIImage imageNamed:@"BeamMusicPlayerController.bundle/images/play.png"];
    } else {
        self.playButton.image = [UIImage imageNamed:@"BeamMusicPlayerController.bundle/images/pause.png"];
    }
}

-(void)pause {
    [[MySingleton sharedInstance]pause];
    self.playing=NO;
    [self stopPlaybackTickTimer];
    
    [self adjustPlayButtonState];
    

}
- (void)stopPlaybackTickTimer {
    [self.playbackTickTimer invalidate];
    self.playbackTickTimer = nil;
}
- (IBAction)previosAction:(id)sender{
    _numberOfSong=_numberOfSong-1;
    song=[self.dataGot objectAtIndex:_numberOfSong];
  
    NSURL *Url1=[song valueForProperty:MPMediaItemPropertyAssetURL];
    currentItem = [AVPlayerItem playerItemWithURL:Url1];
    [[MySingleton sharedInstance]playWithItem:currentItem];
    [self updateUIForCurrentTrack] ;
    [self adjustPlayButtonState];
    

}

- (IBAction)playPause:(id)sender {
    if (self.playing){
          [self pause];
    }
    else{
        [self play];
    }
   
}

- (IBAction)nextAction:(id)sender {
    _numberOfSong=_numberOfSong+1;
    song=[self.dataGot objectAtIndex:_numberOfSong];
    
    NSURL *Url1=[song valueForProperty:MPMediaItemPropertyAssetURL];
    currentItem = [AVPlayerItem playerItemWithURL:Url1];
    [[MySingleton sharedInstance]playWithItem:currentItem];
    [self updateUIForCurrentTrack];
    [self adjustPlayButtonState];
    
}

- (IBAction)valueChanged:(OBSlider *)sender {
    self.currentPlaybackPosition = self.progressSlider.value;
    NSLog(@"currentPlaybackPosition - %f", self.currentPlaybackPosition);

    [[MySingleton sharedInstance]seekToTIme:self.progressSlider.value];
    [self updateSeekUI];
}


- (IBAction)sliderDidBeginScrubbing:(OBSlider *)sender {
    self.scrobbling = YES;
}


- (IBAction)startStreamButton:(id)sender {
}

- (IBAction)sliderDidEndScrubbing:(OBSlider *)sender {
    self.scrobbling = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
