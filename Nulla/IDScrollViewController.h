//
//  IDScrollViewController.h
//  Nulla
//
//  Created by admin on 19.07.14.
//  Copyright (c) 2014 Artur Guseynov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDScrollableTabBarDelegate.h"

@interface ViewController : UIViewController <IDScrollableTabBarDelegate>
@property (weak, nonatomic) IBOutlet UIView *firstView;
@end
