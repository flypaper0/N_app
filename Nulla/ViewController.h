//
//  ViewController.h
//  Nulla
//
//  Created by admin on 18.07.14.
//  Copyright (c) 2014 Artur Guseynov. All rights reserved.
// Основной контроллер

#import <UIKit/UIKit.h>
#import "IDScrollableTabBarDelegate.h"
#import "NLSegue.h"
#import "NLMediaViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "NullaAudipPlayer.h"




BOOL *artistsflag,*albumflag,*songsflag;;

@interface ViewController : UIViewController<IDScrollableTabBarDelegate,  UITableViewDataSource,UITableViewDelegate>{
    MPMediaQuery *artistsQuery,*albumQuery,*SongsQuery;// Медиатека по исполнителям/альбомам/песням
    NSArray *artistsArray,*sectionedArtistsArray, *albumArray,*sectionedAlbumArray;// массивы артистов/артистов деленных по буквам и альбомов //альбомов разделенных по буквам
    UILocalizedIndexedCollation *collation;// отвечает за язык секторов таблицы
}
//artists
@property (nonatomic, retain) MPMediaQuery *artistsQuery;
@property (nonatomic, retain) NSArray *artistsArray,*sectionedArtistsArray;
@property (nonatomic, retain) UILocalizedIndexedCollation *collation;
- (NSArray *)partitionObjects:(NSArray *)array collationStringSelector:(SEL)selector;// Функция, которая сортирует массив музыальных объектов по буквам, то есть создает массив в массиве в котором лежат итемы соответсвующей буквы


@property (nonatomic, retain) MPMediaQuery *albumQuery;
@property (nonatomic, retain) NSArray *albumArray,*sectionedAlbumArray;

@property (nonatomic, retain) MPMediaQuery *songQuery;
@property (nonatomic, retain) NSArray *songArray,*sectionedSongArray;



@property(nonatomic, readonly) NSArray *sectionIndexTitles;


@property (strong, nonatomic) IBOutlet UITableView *tableView;//таблица

@property (strong, nonatomic) IBOutlet UIView *secondView;//Виды, не понадобились, но из за констант убрать не могу
@property (strong, nonatomic) IBOutlet UIView *firstView;





- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation;// не помню, зачем написал
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;//количество строк в секторе буквы
@end
