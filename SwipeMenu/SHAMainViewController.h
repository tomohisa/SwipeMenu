//
//  SHAMainViewController.h
//  SwipeMenu
//
//  Created by Tomohisa Takaoka on 11/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SHAFlipsideViewController.h"
#import "SHAMainScrollView.h"
@interface SHAMainViewController : UIViewController <SHAFlipsideViewControllerDelegate, UIPopoverControllerDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;
@property (strong, nonatomic) IBOutlet SHAMainScrollView* mainScrollView;
@end
