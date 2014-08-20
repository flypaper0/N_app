//
//  ViewController.m
//  Nulla
//
//  Created by admin on 18.07.14.
//  Copyright (c) 2014 Artur Guseynov. All rights reserved.
//

#import "ViewController.h"
#import "IDScrollableTabBar.h"

NLMediaViewController *oldvc;
@interface ViewController ()

@end

@implementation ViewController
{
     NSMutableDictionary *_viewControllersByIdentifier;
}
@synthesize artistsQuery,albumQuery,artistsArray,sectionedArtistsArray,albumArray,sectionedAlbumArray, songQuery,songArray, sectionedSongArray, collation,firstView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    IDItem *item1 = [[IDItem alloc] initWithImage:[UIImage imageNamed:@"music"] text:@"artists"];//Создание итемов для костомного тулбара через специальный класс, который лежит в отдельнйо папке
    IDItem *item2 = [[IDItem alloc] initWithImage:[UIImage imageNamed:@"music"] text:@"albums"];
    IDItem *item3 = [[IDItem alloc] initWithImage:[UIImage imageNamed:@"music"] text:@"songs"];
    IDItem *item4 = [[IDItem alloc] initWithImage:[UIImage imageNamed:@"music"] text:@"playlists"];
    IDItem *item5 = [[IDItem alloc] initWithImage:[UIImage imageNamed:@"music"] text:@"generus"];
  

    IDScrollableTabBar *scrollableTabBar = [[IDScrollableTabBar alloc] initWithFrame:CGRectMake(0, 2, 320, 0) itemWidth:80 items:item1,item2,item3,item4,item5, nil];//создание тулбара
    scrollableTabBar.delegate = self;
    scrollableTabBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    [scrollableTabBar setSelectedItem:0 animated:NO];
    [self.firstView addSubview:scrollableTabBar];//Добавление скрулбара к виду
    artistsflag=YES;//флаги выбранной медиотеки
    albumflag=NO;
    songsflag=NO;
}

- (NSArray *)partitionObjects:(NSArray *)array collationStringSelector:(SEL)selector//сортировка по буквам медиотеки
{
    self.collation = [UILocalizedIndexedCollation currentCollation];//получаю буквы языка системы

    NSInteger sectionCount = [[collation sectionTitles] count];//получаю общее количество букв
    NSMutableArray *sortedSections = [NSMutableArray arrayWithCapacity:sectionCount];//создаю массив для хранения отсортированных
    for(int i = 0; i < sectionCount; i++)
        [sortedSections addObject:[NSMutableArray array]];//сортирую и добавляю
    
    for (id object in array)
    {
        NSInteger index = [self.collation sectionForObject:object collationStringSelector:selector];
        [[sortedSections objectAtIndex:index] addObject:object];
    }
    
    return sortedSections;
}
//Название секций, туда передаются буквы
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[self.collation sectionTitles] objectAtIndex:section];
}
//индексы сооветсвующих букв
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {

    return [self.collation sectionIndexTitles];

}
//Количество секций в таблице
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 
    return [[self.collation sectionTitles] count];
  
 
}
//количество строк в секции
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (artistsflag){
        return [[self.sectionedArtistsArray objectAtIndex:section] count];
    }
    else {
        
        if (albumflag){
            return [[self.sectionedAlbumArray objectAtIndex:section] count];
        }
        else {
            if (songsflag){
                return [[self.sectionedSongArray objectAtIndex:section] count];
            }
            else{
                return 0;
            }
        }
    }
}
//Заполнение ячеек таблицы
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MusicCell";//индификатор ячейки
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        // если нет ячейки - создаем
        cell = [[UITableViewCell alloc] init];
    }
    //Если флаг артистов активен
    if (artistsflag){
       MPMediaItem *temp = [[self.sectionedArtistsArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];//из отсортированного массива артистов получаем один итем
    cell.textLabel.text = [temp valueForProperty:MPMediaItemPropertyAlbumArtist];//записываем в табличку имя артиста
    cell.detailTextLabel.text=@"";//второе поле записи. Здесь пустое
         cell.imageView.image=nil;//изображений нте
    }
    if (albumflag){//Тоже самое но для альбомов
        MPMediaItem *temp2 = [[self.sectionedAlbumArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        cell.textLabel.text = [temp2 valueForProperty:MPMediaItemPropertyAlbumTitle];
            cell.detailTextLabel.text=[temp2 valueForProperty:MPMediaItemPropertyAlbumArtist];
        UIImage *albumImage=[[temp2 valueForProperty:MPMediaItemPropertyArtwork] imageWithSize:CGSizeMake(40, 40)];//получаю картинку альбома
        NSData *imageData=UIImagePNGRepresentation(albumImage);//Преобразую ее в другой формат
        //Если абложка была, то произвожу запись ее, если нет - базовая картинка
        if (albumImage !=nil) {
            cell.imageView.image=[UIImage imageWithData:imageData];
        }
        else{
            cell.imageView.image=[UIImage imageNamed:@"BeamMusicPlayerController.bundle/images/noartplaceholder.png"];
        }
        
    }
    if (songsflag){//тоже самое, уже надоело
         MPMediaItem *temp3 = [[self.sectionedSongArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        cell.textLabel.text = [temp3 valueForProperty:MPMediaItemPropertyTitle];
        cell.detailTextLabel.text=[temp3 valueForProperty:MPMediaItemPropertyAlbumArtist];
        cell.imageView.image=nil;
    }
    
    return cell;
}


- (void)didReceiveMemoryWarning//на случай если слишком много памяти занимает, не доработал
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//Эта хрень отвечает за происходящие при переключении вкладок. Реализованно не рационально, но как есть, тут все подробно

-(void)scrollTabBarAction : selectedNumber sender:(id)sender{
    NSLog(@"selectedNumber - %@", selectedNumber);
    self.tableView.dataSource =self;
    self.tableView.delegate = self;
    //0, базово выбранный итем тулбара
        if ([selectedNumber intValue]==0){
            artistsflag=YES;//меняем флаги
            albumflag=NO;
            songsflag=NO;
            //Получаем медиотеку артистов
            self.artistsQuery = [MPMediaQuery artistsQuery];
            //Сортируем артистов
            [self.artistsQuery setGroupingType:MPMediaGroupingAlbumArtist];
            //получаем массив из отсортированных по секторам
            self.artistsArray = [self.artistsQuery collections];
            
            //создаем пустой массив
            NSMutableArray *artists = [NSMutableArray array];
            //берем по одному артистов из прошлого массива и перезаписываем в новый. Все дело в типе массива, почитай Референс
            for (MPMediaItemCollection *artist in artistsArray) {
                
                MPMediaItem *representativeItem = [artist representativeItem];//Вытаскиваем артиста
                
                [artists addObject:representativeItem];//Добавляем в новый массив
            }
            //Получаем отсортированный массив путем передачи старого массива, селектор по артистам
            self.sectionedArtistsArray = [self partitionObjects:artists collationStringSelector:@selector(albumArtist)];
            //Перезагружаем таблицу
            [self.tableView reloadData];
        }
    if ([selectedNumber intValue]==1){
        artistsflag=NO;//теже флаги
        albumflag=YES;
        songsflag=NO;
        collation=nil;// Может и не нужно, но работе не мешает
        self.albumQuery = [MPMediaQuery albumsQuery];//Тоже что и выше, но с альбомами
        
        [self.albumQuery setGroupingType:MPMediaGroupingAlbum];
         self.albumArray = [self.albumQuery collections];
       
        
        
        
        NSMutableArray *albums = [NSMutableArray array];
        
        for (MPMediaItemCollection *album in albumArray) {
            
            MPMediaItem *representativeItem = [album representativeItem];
            
            [albums addObject:representativeItem];
        }
        
        self.sectionedAlbumArray = [self partitionObjects:albums collationStringSelector:@selector(albumTitle)];
        [self.tableView reloadData];
        
    }
    if ([selectedNumber intValue]==2){
        artistsflag=NO;
        albumflag=NO;//Те же флаги, только в профиль
        songsflag=YES;
        collation=nil;
        self.songQuery=[MPMediaQuery songsQuery];
        self.songArray=[self.songQuery items];
        NSMutableArray *songs = [NSMutableArray array];//Все тоже самое, но с песнями и плясками
        
        for (MPMediaItemCollection *song in songArray) {
            
            MPMediaItem *representativeItem = [song representativeItem];
            
            [songs addObject:representativeItem];
        }
        
        self.sectionedSongArray = [self partitionObjects:songs collationStringSelector:@selector(title)];
        [self.tableView reloadData];
    }
    
    
}
//Ячейку выбрали
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (artistsflag){
        //Внимание, я придумал как минимум два способа легче, но не успел реализовать. До моего приезда лучше не трогай
        //Берем медиотеку альбомов, стандартно сортируем
        self.albumQuery = [MPMediaQuery albumsQuery];
        [self.albumQuery setGroupingType:MPMediaGroupingAlbum];
        self.albumArray = [self.albumQuery collections];
        //берем ячейку
        UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
        //Получаем имя артиста из ячейки
        NSString *artistName =cell.textLabel.text;
        //Массив, куда мы запихнем все нужное
        NSMutableArray *data = [NSMutableArray array];
        //Начинаем искать по альбомам
        for (MPMediaItemCollection *album in albumArray) {
            MPMediaItem *representativeItem = [album representativeItem];//берем альбрм
            NSString *artist= [representativeItem valueForProperty:MPMediaItemPropertyArtist];//Достаем имя артиста
            //Если имя артиста этого альбома и имя артиста из ячейки совпало
            if([artist isEqualToString:artistName]){
                [data addObject:representativeItem];//Добавляем альбом в дату
                NSLog(@"Album found");
            }
        }
        //Тут передача данных на другой контроллер, сделал без связей, так как ЭТО ЛЕГЧЕ и АБСОЛЮТНО НЕ ВЛИЯЕТ
        //Индификатор контроллера на который буду передавать данные
        _viewControllersByIdentifier = @"NLMediaViewController";
        //Присвоил контроллер переменной
        NLMediaViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:_viewControllersByIdentifier];
        //В специально созданные свойства на другом контроллере передаю все нужно и важное
        vc.dataGot=data;
        vc.flag=0;//Это особый флажок. О нем позже
        [self.navigationController pushViewController:vc animated:YES];//Так сделанно через навигатор контрллер - приказ перейти на другой вид идет через него
        
    }
    //Тоже самое, только среди песен ищем альбомы. Знаю, не рационально, но хоть работает
    if (albumflag){
        self.songQuery=[MPMediaQuery songsQuery];
        self.songArray=[self.songQuery items];
        
        UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
        NSString *albumName =cell.textLabel.text;
        NSMutableArray *data = [NSMutableArray array];
        for (MPMediaItemCollection *song in songArray) {
            MPMediaItem *representativeItem = [song representativeItem];
            NSString *album= [representativeItem valueForProperty:MPMediaItemPropertyAlbumTitle];
            if([album isEqualToString:albumName]){
                [data addObject:representativeItem];
                NSLog(@"song found");
            }
        }
        _viewControllersByIdentifier = @"NLMediaViewController";
        NLMediaViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:_viewControllersByIdentifier];
        vc.dataGot=data;
        vc.flag=1;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    //Песни. Тут слега по другому
    if (songsflag){
        //берем песню из ячейки
        MPMediaItem *song = [[self.sectionedSongArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
       _viewControllersByIdentifier = @"NullaAudio";
        NullaAudipPlayer*nap=[self.storyboard instantiateViewControllerWithIdentifier:_viewControllersByIdentifier];
        //Передаем все наши песни туда - листать же мы их будем как то
        nap.dataGot=songArray;
        int count=[songArray indexOfObject:song];//idex pesni
        nap.song=song;//Передаем песню
        nap.numberOfSong=count;//peredaem nomer tekushei pesni
        [self.navigationController pushViewController:nap animated:YES];
        
    }
}





#pragma mark - Segues

// - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:self
//{
//    if (!dataSend==0)
//    {
//        NLMediaViewController * nlvc = (NLMediaViewController *)[segue destinationViewController];
//        nlvc.self.dataGot=dataSend;
//    }
//}


@end