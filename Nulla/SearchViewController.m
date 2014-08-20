//
//  SearchViewController.m
//  Nulla
//
//  Created by artur on 19.08.14.
//  Copyright (c) 2014 Artur Guseynov. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController () <TDSessionDelegate>

{
    NSString  *_viewControllersByIdentifier;
}

@property (strong, nonatomic) IBOutlet UILabel *songTitle;
@property (strong, nonatomic) TDAudioInputStreamer *inputStream;
@property (strong, nonatomic) NSString *deviceName;
@property (strong, nonatomic) TDSession *session;
@property (strong, nonatomic) IBOutlet UIImageView *albumImage;
@property (strong, nonatomic) IBOutlet UILabel *songArtist;

@end

@implementation SearchViewController
@synthesize sessionFromHost;

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
    // Do any additional setup after loading the view.
    
    self.deviceName = [[UIDevice currentDevice] name];
    self.session = [[TDSession alloc] initWithPeerDisplayName:@"Guest"];
    self.session.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
//    NLMediaViewController *dataSaver = [self.storyboard instantiateViewControllerWithIdentifier:@"NLMediaViewController"];
//    
    if (self.sessionFromHost == nil) {
    [self presentViewController:[sessionFromHost browserViewControllerForSeriviceType:@"dance-party"] animated:YES completion:nil];
    }
    else {
        NSLog(@"session is nil");
    }
        

    NSLog(@"Search will appear");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeSongInfo:(NSDictionary *)info
{
    if (info[@"artwork"])
        self.albumImage.image = info[@"artwork"];
    else
        self.albumImage.image = nil;
    
    self.songTitle.text = info[@"title"];
    self.songArtist.text = info[@"artist"];
}

- (void)session:(TDSession *)session didReceiveData:(NSData *)data
{
    NSDictionary *info = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [self performSelectorOnMainThread:@selector(changeSongInfo:) withObject:info waitUntilDone:NO];
}

- (void)session:(TDSession *)session didReceiveAudioStream:(NSInputStream *)stream
{
    if (!self.inputStream) {
        self.inputStream = [[TDAudioInputStreamer alloc] initWithInputStream:stream];
        [self.inputStream start];
    }
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
