//
//  SHAMainScrollView.m
//  SwipeMenu
//
//  Created by Tomohisa Takaoka on 11/8/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SHAMainScrollView.h"


@interface SHAMainScrollView()
-(void) handleSwipeRight:(id)sender;
@end

@implementation SHAMainScrollView {
    UISwipeGestureRecognizer *swipeRight;
    UIView *viewMenu;
    UIImageView *imageViewMenu;
}


@synthesize innerScrollView;
-(id) initWithCoder:(NSCoder *)aDecoder {
    if ((self=[super initWithCoder:aDecoder])) {
        self.contentSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height * 2);
        [self setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        
        self.innerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width - 0, self.bounds.size.height - 0)];
        innerScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        self.innerScrollView.showsVerticalScrollIndicator = NO;
        self.innerScrollView.showsHorizontalScrollIndicator = NO;
        [innerScrollView setScrollEnabled:YES];
        innerScrollView.contentSize = CGSizeMake(innerScrollView.bounds.size.width * 3, innerScrollView.bounds.size.height);
        innerScrollView.pagingEnabled = YES;
        
        UIView* imageView = [[UIView alloc] initWithFrame:self.bounds];
        imageView.backgroundColor = [UIColor redColor];
        imageView.center = innerScrollView.center;
        [innerScrollView addSubview:imageView];
        
        imageView = [[UIView alloc] initWithFrame:self.bounds];
        imageView.backgroundColor = [UIColor blueColor];
        imageView.center = CGPointMake(innerScrollView.center.x + innerScrollView.bounds.size.width, innerScrollView.center.y) ;
        [innerScrollView addSubview:imageView];

        imageView = [[UIView alloc] initWithFrame:self.bounds];
        imageView.backgroundColor = [UIColor greenColor];
        imageView.center = CGPointMake(innerScrollView.center.x + innerScrollView.bounds.size.width * 2, innerScrollView.center.y) ;
        [innerScrollView addSubview:imageView];

        innerScrollView.bounces = YES;
        innerScrollView.alwaysBounceVertical = NO;
        innerScrollView.alwaysBounceHorizontal = YES;
        [self addSubview:innerScrollView];
        
        imageViewMenu = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"popupMenu.png"]];
        viewMenu = [[UIView alloc] initWithFrame:CGRectMake(44 - imageViewMenu.image.size.width, self.bounds.size.height - 0 - imageViewMenu.image.size.height, imageViewMenu.image.size.width, imageViewMenu.image.size.height)];
        imageViewMenu.frame = CGRectMake(0, 0, imageViewMenu.image.size.width, imageViewMenu.image.size.height);
        [self addSubview:viewMenu];
        [viewMenu addSubview:imageViewMenu];
        
        swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
        swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
        swipeRight.delegate = self;
        [self addGestureRecognizer:swipeRight];
        [self.panGestureRecognizer requireGestureRecognizerToFail:swipeRight];
        [self.innerScrollView.panGestureRecognizer requireGestureRecognizerToFail:swipeRight];
        
        UIButton* button;
        float y=35;
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"button_bookmark.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"sel_button_bookmark.png"] forState:UIControlStateSelected | UIControlStateHighlighted];
        button.frame = CGRectMake(-2, y, 125, 44);
        [viewMenu addSubview:button];
        y+=44;
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"button_refresh.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"sel_button_refresh.png"] forState:UIControlStateSelected | UIControlStateHighlighted];
        button.frame = CGRectMake(-2, y, 125, 44);
        [viewMenu addSubview:button];
        y+=44;
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"button_search.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"sel_button_search.png"] forState:UIControlStateSelected | UIControlStateHighlighted];
        button.frame = CGRectMake(-2, y, 125, 44);
        [viewMenu addSubview:button];
        y+=44;
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"button_shop.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"sel_button_shop.png"] forState:UIControlStateSelected | UIControlStateHighlighted];
        button.frame = CGRectMake(-2, y, 125, 44);
        [viewMenu addSubview:button];
        y+=44;
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"button_info.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"sel_button_info.png"] forState:UIControlStateSelected | UIControlStateHighlighted];
        button.frame = CGRectMake(-2, y, 125, 44);
        [viewMenu addSubview:button];
        y+=44;
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"button_help.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"sel_button_help.png"] forState:UIControlStateSelected | UIControlStateHighlighted];
        button.frame = CGRectMake(-2, y, 125, 44);
        [viewMenu addSubview:button];
        
        

    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch
{
    if (gestureRecognizer==swipeRight) {
        UIScrollView *scrollView = self;
        CGPoint touchPoint = [touch locationInView:scrollView];
        if (!CGRectContainsPoint(viewMenu.frame,touchPoint))
            return NO;
    }
    return YES; 
}

-(void) handleSwipeRight:(id)sender {
    [UIView animateWithDuration:.1 delay:.2 options:UIViewAnimationTransitionNone animations:^{
        if (swipeRight.direction == UISwipeGestureRecognizerDirectionRight) {
            viewMenu.frame = CGRectMake(0, self.bounds.size.height - 0 - imageViewMenu.image.size.height, imageViewMenu.image.size.width, imageViewMenu.image.size.height);
        }else{
            viewMenu.frame = CGRectMake(44 - imageViewMenu.image.size.width, self.bounds.size.height - 0 - imageViewMenu.image.size.height, imageViewMenu.image.size.width, imageViewMenu.image.size.height);
        }
    } completion:^(BOOL finished) {
        if (swipeRight.direction == UISwipeGestureRecognizerDirectionRight) {
            swipeRight.direction = UISwipeGestureRecognizerDirectionLeft;
        }else{
            swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
        }
    }];
}
@end
