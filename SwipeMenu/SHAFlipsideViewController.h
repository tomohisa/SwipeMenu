//
//  SHAFlipsideViewController.h
//  SwipeMenu
//
//  Created by Tomohisa Takaoka on 11/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SHAFlipsideViewController;

@protocol SHAFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(SHAFlipsideViewController *)controller;
@end

@interface SHAFlipsideViewController : UIViewController

@property (weak, nonatomic) IBOutlet id <SHAFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
