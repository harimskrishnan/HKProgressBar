//
//  HKViewController.m
//  ProgressBar
//
//  Created by Hari on 23/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HKViewController.h"

@implementation HKViewController

@synthesize progressBar;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    progressBar.barColor = [UIColor redColor];
    progressBar.barBackgroundColor = [UIColor purpleColor];
    progressBar.patternImageForBar = [UIImage imageNamed:@"pattern.png"];
    [self.progressBar setProgressLevel:[NSNumber numberWithInt:0]];
    
    [self performSelector:@selector(incrementBar) withObject:nil afterDelay:.5];
    
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)incrementBar
{
    double curentProgress = [progressBar.progress doubleValue];
    [progressBar setProgressLevel:[NSNumber numberWithDouble:curentProgress+.05]];
    
    if (![progressBar isComplete]) [self performSelector:@selector(incrementBar) withObject:nil afterDelay:1];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
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

@end
