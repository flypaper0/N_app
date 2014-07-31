//
//  NLMediaViewController.m
//  Nulla
//
//  Created by admin on 20.07.14.
//  Copyright (c) 2014 Artur Guseynov. All rights reserved.
//

#import "NLMediaViewController.h"

@interface NLMediaViewController ()

@end

@implementation NLMediaViewController
@synthesize dataGot,sectionedArray;
//Инициализация с именем для передлачи
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"NLMediaViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    //Объявляем делигатов и дата сорс, перезагружаем табличку
    self.tableView.dataSource =self;
    self.tableView.delegate = self;
    [self.tableView reloadData];
    [super viewDidLoad];
  
    // Do any additional setup after loading the view.
}
//Ячейки таблицы
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Опять задаем индификаторы для ячеек. Сейчас это не кртично, но в планах сделать еще один вид ячеек
    static NSString *cellIdentifier = @"MusicCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    if (_flag==0){
        //Получаем медия итем из переданных нам данныъ
        MPMediaItem *temp = [self.dataGot  objectAtIndex:indexPath.row];
        //Заполняем ячейку нужным, про картинки уже было в том контролере
        cell.textLabel.text = [temp valueForProperty:MPMediaItemPropertyAlbumTitle];
        cell.detailTextLabel.text=@"";
        UIImage *albumImage=[[temp valueForProperty:MPMediaItemPropertyArtwork] imageWithSize:CGSizeMake(40, 40)];
        NSData *imageData=UIImagePNGRepresentation(albumImage);
        if (albumImage !=nil) {
        cell.imageView.image=[UIImage imageWithData:imageData];
        }
        else{
            cell.imageView.image=[UIImage imageNamed:@"BeamMusicPlayerController.bundle/images/noartplaceholder.png"];
        }
    }
    if (_flag==1){//Тоже самое
          MPMediaItem *temp = [self.dataGot  objectAtIndex:indexPath.row];
          cell.textLabel.text = [temp valueForProperty:MPMediaItemPropertyTitle];
          cell.detailTextLabel.text=@"";
      }
    return cell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Колимчество ячеек в секции
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataGot count];
}

#pragma mark - Navigation



@end
