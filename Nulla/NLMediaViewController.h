//
//  NLMediaViewController.h
//  Nulla
//
//  Created by admin on 20.07.14.
//  Copyright (c) 2014 Artur Guseynov. All rights reserved.
//Контроллер всего другого

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "ViewController.h"
#import "AppDelegate.h"
#import "TDAudioStreamer.h"
#import "TDSession.h"



@interface NLMediaViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *dataGot;//Полученные данные медиотеки
    NSArray *sectionedArray;//отсортированный массив
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *firstView;//Оба виды сомнительной нужности ,их функции уже отпали
@property (strong, nonatomic) IBOutlet UIView *passingView;
@property (nonatomic, retain) NSArray *sectionedArray;
@property (weak, nonatomic) IBOutlet UIImageView *UIImage;//Картинка

@property (strong,nonatomic) NSArray *dataGot;
@property (nonatomic,readwrite )NSInteger *flag;

@property (strong,nonatomic) TDSession *session;

@end
