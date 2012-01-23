//
//  EMBProgressbar.m
//  PSM-i 1.0
//
//  Created by Hari on 21/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "HKProgressbar.h"
#import <QuartzCore/QuartzCore.h>

@implementation HKProgressbar

@synthesize barColor;

@synthesize barBackgroundColor, delegate, progress, complete;

@synthesize patternImageForBar, patternImageForBarBackground;

- (void)baseInit 
{
    
    self.barColor = [UIColor colorWithRed:.1f  green:.55f blue:0.90f alpha:1];
    self.barBackgroundColor = [UIColor colorWithRed:.05f  green:0.11f blue:.46f alpha:1];
    self.backgroundColor = [UIColor clearColor];
    barLength= 0;
    complete = NO;
    self.progress = 0;
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self baseInit];
        [self setNeedsDisplay];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self baseInit];
    }
    return self;
}
-(BOOL)isComplete
{
    return complete;
}

-(UIImage *)patterenedImageWithImage:(UIImage *)image andPattern:(UIImage *)pattern
{
    
    CGSize newSize = pattern.size;
    UIGraphicsBeginImageContext( newSize );
    
    // Use existing opacity as is
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Apply supplied opacity
    [pattern drawInRect:CGRectMake(0,0,newSize.width,newSize.height) blendMode:kCGBlendModeOverlay alpha:1];
    
    UIImage *patternedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return patternedImage;
}

-(void)drawRect:(CGRect)rect
{
    UIImage *barImage;
    UIImage *backgroundImage;
    barImage = [self imageWithGradientFromColor:[barColor colorWithAlphaComponent:.7] toColor:barColor];
    backgroundImage = [self imageWithGradientFromColor:[barBackgroundColor colorWithAlphaComponent:.6] toColor:barBackgroundColor];
    
   
    
    
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:backgroundImageView];
    
    backgroundImageView.backgroundColor = [UIColor clearColor];
    [backgroundImageView.layer setCornerRadius:10.0f];
    [backgroundImageView.layer setMasksToBounds:YES];
    [backgroundImageView.layer setBorderColor:[barBackgroundColor CGColor]];
    [backgroundImageView.layer setBorderWidth:3];
    
    if (patternImageForBarBackground) 
    {
        backgroundImage = [self patterenedImageWithImage:backgroundImage andPattern:patternImageForBarBackground];
        UIColor *patternColor = [UIColor colorWithPatternImage:backgroundImage];
        backgroundImageView.backgroundColor = patternColor;
    }
    else [backgroundImageView setImage:backgroundImage];

    
    
    progressBarView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, barLength, self.frame.size.height - 6)];
    [self addSubview:progressBarView];
    
    progressBarView.backgroundColor = [UIColor clearColor];
    [progressBarView.layer setCornerRadius:8.0f];
    [progressBarView.layer setMasksToBounds:YES];
    if (patternImageForBar)
    {
        barImage = [self patterenedImageWithImage:barImage andPattern:patternImageForBar];
        UIColor *patternColor = [UIColor colorWithPatternImage:barImage];
        progressBarView.backgroundColor = patternColor; 
    }
    else [progressBarView setImage:barImage];
    
        
    percentage = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width - 80, 5, 70, self.frame.size.height-10) ];
    [self addSubview:percentage];
    percentage.backgroundColor = [UIColor clearColor];
    percentage.textColor =[UIColor whiteColor];
    percentage.shadowColor = [UIColor darkGrayColor];
    percentage.textAlignment = UITextAlignmentCenter;
    
}

-(void)setProgressLevel:(NSNumber *)level
{
    
    self.progress = level;
    float currentProgress = [level floatValue];
    if (currentProgress > 1) {
        currentProgress = 1;
    }
    
    if (currentProgress >=1) complete = YES;
    
    float frameLength = self.frame.size.width - 6;
    
    barLength = frameLength * currentProgress;
    NSString *currentPercentage = [NSString stringWithFormat:@"%.1f",currentProgress*100];
    percentage.text =  [currentPercentage stringByAppendingString:@"%"];
    CGRect barSize = CGRectMake(3, 3, barLength, progressBarView.frame.size.height);
    
    progressBarView.frame = barSize;
    
    
}

//CREATING A GRADIENT IMAGE WITH PROVIDED UICOLORS ----- START
-(UIImage *)imageWithGradientFromColor:(UIColor *)colorOne toColor:(UIColor *)colorTwo
{
	CGGradientRef myGradient;
	
	CGColorSpaceRef myColorspace = CGColorSpaceCreateDeviceRGB();
	
	size_t num_locations = 2;
	
	CGFloat locations[2] = { 0.0, 1.0 };
	
	CGFloat components[8];
	
	CGColorRef topColor = colorOne.CGColor;
	
	CGColorRef bottomColor = colorTwo.CGColor;
	
	int numComponents = CGColorGetNumberOfComponents(topColor);
	
	const CGFloat *components1 = CGColorGetComponents(topColor);
	
	for(int i =0 ; i<numComponents ; i++)
	{
		components[i] = components1[i];
	}
	
	numComponents = CGColorGetNumberOfComponents(bottomColor);
	
	const CGFloat *components2 = CGColorGetComponents(bottomColor);
	
	for(int i =0 ; i<numComponents ; i++)
	{
		components[i+4] = components2[i];
	}
	
	myGradient = CGGradientCreateWithColorComponents (myColorspace, components,
													  
													  locations, num_locations);
	CGPoint myStartPoint, myEndPoint;
	
	myStartPoint.x = 0.0;
	
	myStartPoint.y = 0.0;
	
	myEndPoint.x = 1.0;
	
	myEndPoint.y = 10.0;
	
	self.backgroundColor = [UIColor clearColor]; 
	
	UIGraphicsBeginImageContext(CGSizeMake(1, 10));
	
	CGContextDrawLinearGradient (UIGraphicsGetCurrentContext(), myGradient, myStartPoint, myEndPoint, 0);
	
	UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
	
	UIGraphicsEndImageContext();
	
	return gradientImage;
}
//CREATING A GRADIENT IMAGE WITH PROVIDED UICOLORS ----- END
@end
