//
//  IDScrollViewController.m
//  Nulla
//
//  Created by admin on 19.07.14.
//  Copyright (c) 2014 Artur Guseynov. All rights reserved.
//

#import "IDScrollViewController.h"
#import "IDScrollableTabBar.h"

@interface ViewController ()

@end

@implementation ViewController

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
        // Do any additional setup after loading the view, typically from a nib.
        //create items
        IDItem *itemClock = [[IDItem alloc] initWithImage:[UIImage imageNamed:@"clock"] text:@"clock"];
        IDItem *itemCamera = [[IDItem alloc] initWithImage:[UIImage imageNamed:@"camera"] text:@"camera"];
        IDItem *itemMail = [[IDItem alloc] initWithImage:[UIImage imageNamed:@"mail"] text:@"e-mail"];
        IDItem *itemFave = [[IDItem alloc] initWithImage:[UIImage imageNamed:@"fave"] text:@"favourite"];
        IDItem *itemGames = [[IDItem alloc] initWithImage:[UIImage imageNamed:@"games"] text:@"games"];
        IDItem *itemSettings = [[IDItem alloc] initWithImage:[UIImage imageNamed:@"settings"] text:@"settings"];
        IDItem *itemMusic = [[IDItem alloc] initWithImage:[UIImage imageNamed:@"music"] text:@"music"];
        IDItem *itemZip = [[IDItem alloc] initWithImage:[UIImage imageNamed:@"zip"] text:@"zip"];
        //scrollable tab bar by default
        //require default folder
        IDScrollableTabBar *scrollableTabBar = [[IDScrollableTabBar alloc] initWithFrame:CGRectMake(0, 30, 320, 0) itemWidth:80 items:itemClock,itemCamera,itemMail,itemFave,itemGames,itemSettings,itemMusic,itemZip, nil];
        scrollableTabBar.delegate = self;
        scrollableTabBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
        [scrollableTabBar setSelectedItem:0 animated:NO];
        [self.firstView addSubview:scrollableTabBar];
        
        //blue scrollable tab bar
        //require blueImages folder
        
        //colored scrollable tab bar
        //require crazy folder
        IDScrollableTabBar *scrollableTabBarColored = [[IDScrollableTabBar alloc] initWithFrame:CGRectMake(0, 1, 320, 0) itemWidth:80 items:itemClock,itemCamera,itemMail,itemFave,itemGames,itemSettings,itemMusic,itemZip, nil];
        scrollableTabBarColored.delegate = self;
        scrollableTabBarColored.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
        [scrollableTabBarColored setArchImage:[UIImage imageNamed:@"crazyArch"] centerImage:[UIImage imageNamed:@"crazyCenter"] backGroundImage:[UIImage imageNamed:@"crazyBackground"]];
        [scrollableTabBarColored setDividerImage:nil];
        [scrollableTabBarColored setShadowImageRight:nil];
        [scrollableTabBarColored setShadowImageLeft:nil];
 
    }
    
    - (void)didReceiveMemoryWarning
    {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }
    -(void)scrollTabBarAction : (NSNumber *)selectedNumber sender:(id)sender{
        NSLog(@"selectedNumber - %@", selectedNumber);
    }
    - (void)viewDidUnload {
        [self setFirstView:nil];
        [super viewDidUnload];
    }

    - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
    {
        return YES;
    }
    
    - (NSUInteger)supportedInterfaceOrientations
    {
        return UIInterfaceOrientationMaskAll;
    }
    @end
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


