//
//  SHAMainViewController.m
//  SwipeMenu
//
//  Created by Tomohisa Takaoka on 11/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SHAMainViewController.h"

@implementation SHAMainViewController{
    UIImageView *imageViewNotPurchased;
    int pageNow;
}

@synthesize managedObjectContext = _managedObjectContext;
@synthesize flipsidePopoverController = _flipsidePopoverController;
@synthesize mainScrollView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    imageViewNotPurchased = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"banner_not_purchased.png"]];
    imageViewNotPurchased.frame = CGRectMake(self.view.bounds.size.width - imageViewNotPurchased.image.size.width, -20, imageViewNotPurchased.image.size.width, imageViewNotPurchased.image.size.height);
//    imageViewNotPurchased.frame = CGRectMake(0,0,100,100);
    [self.view addSubview:imageViewNotPurchased];
    imageViewNotPurchased.alpha = 0.0;
    mainScrollView.innerScrollView.delegate = self;
    
    pageNow = 0;

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - Flipside View Controller

- (void)flipsideViewControllerDidFinish:(SHAFlipsideViewController *)controller
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self dismissModalViewControllerAnimated:YES];
    } else {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.flipsidePopoverController = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
            self.flipsidePopoverController = popoverController;
            popoverController.delegate = self;
        }
    }
}

- (IBAction)togglePopover:(id)sender
{
    if (self.flipsidePopoverController) {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    } else {
        [self performSegueWithIdentifier:@"showAlternate" sender:sender];
    }
}

#pragma mark ScrollView delegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView==self.mainScrollView.innerScrollView) {
        int page = scrollView.contentOffset.x / scrollView.bounds.size.width;
        if (pageNow != page) {
            float alphaToBe = 0.0;
            if (page == 2) {
                alphaToBe = 1.0;
            }
            
            [UIView animateWithDuration:0.5 animations:^{
            imageViewNotPurchased.alpha = alphaToBe;
            }];
            pageNow = page;
            [self.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        
    }
    
    
    
}

@end
