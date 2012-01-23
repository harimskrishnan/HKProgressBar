//
//  EMBProgressbar.h
//  PSM-i 1.0
//
//  Created by Hari on 21/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HKProgressbarDelegate;

@interface HKProgressbar : UIView
{
    UIColor *barColor;
    UIColor *barBackgroundColor;
    UIImage *patternImageForBar;
    UIImage *patternImageForBarBackground;
    NSNumber *progress;
    id<HKProgressbarDelegate> delegate;
    
    @private
    UIImageView *progressBarView;
    UILabel *percentage;
    double barLength;
}

@property(nonatomic, retain) UIColor *barColor;
@property(nonatomic, retain) UIColor *barBackgroundColor;
@property(nonatomic, retain) id<HKProgressbarDelegate> delegate;
@property(nonatomic, retain) NSNumber *progress;
@property(nonatomic,assign,getter = isComplete) BOOL complete;
@property(nonatomic,retain) UIImage *patternImageForBar;
@property(nonatomic,retain) UIImage *patternImageForBarBackground;

-(id)initWithFrame:(CGRect)frame;
-(void)setProgressLevel:(NSNumber *)level;
@end



@interface HKProgressbar (PRIVATE_METHODS)
-(UIImage *)imageWithGradientFromColor:(UIColor *)colorOne toColor:(UIColor *)colorTwo;
-(void)makeProgress;
@end


@protocol HKProgressbarDelegate <NSObject>
@optional
-(NSNumber *)setLevelForProgressBar:(HKProgressbar *)progressBar;
@end