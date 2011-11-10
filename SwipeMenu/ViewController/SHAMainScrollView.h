//
//  SHAMainScrollView.h
//  SwipeMenu
//
//  Created by Tomohisa Takaoka on 11/8/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHAMainScrollView : UIScrollView <UIGestureRecognizerDelegate>
@property (strong, nonatomic) UIScrollView* innerScrollView;

@end
