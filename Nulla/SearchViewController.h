//
//  SearchViewController.h
//  Nulla
//
//  Created by artur on 19.08.14.
//  Copyright (c) 2014 Artur Guseynov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDAudioStreamer.h"
#import "TDSession.h"
#import "NullaAudipPlayer.h"

@interface SearchViewController : UIViewController

@property (strong,nonatomic) TDSession *sessionFromHost;
@end
