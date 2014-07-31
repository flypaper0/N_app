//
//  NLSegue.m
//  Nulla
//
//  Created by admin on 19.07.14.
//  Copyright (c) 2014 Artur Guseynov. All rights reserved.
//

#import "NLSegue.h"
#import "ViewController.h"
#import "NLMediaViewController.h"

@implementation NLSegue



- (void) perform {
    ViewController *tabBarViewController = (ViewController *)self.sourceViewController;
    NLMediaViewController *destinationViewController = (NLMediaViewController *) self.destinationViewController;
    [UIView transitionWithView:tabBarViewController.navigationController.view duration:0.01
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [tabBarViewController.navigationController pushViewController:destinationViewController animated:NO];
                    }
                    completion:NULL];
    
}
    
    


@end


