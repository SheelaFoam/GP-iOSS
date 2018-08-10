/*
 ******************************************************************************
 Copyright (c) 2016, Sheela Foam Pvt Ltd All rights reserved.
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 *
 *****************************************************************************/

#import "POAcvityView.h"
#import <QuartzCore/QuartzCore.h>
#import "MailClassViewController.h"

@interface POAcvityView(PrivateMethods)
- (void)prepareView;
@end

@implementation POAcvityView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Releases memory
- (void)dealloc
{
	}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
#pragma mark PUBLIC METHODS

//Initiazes with title
- (id)initWithTitle:(NSString *)theTitle message:(NSString *)theMessage
{
	CGRect frame = CGRectMake(0,0,320,568);
	
	if (self = [super initWithFrame:frame])
	{
		
		title	= theTitle;
		message = theMessage;
		
		[self prepareView];
	}
	
	return self;
	
}
//Shows the view
- (void) showView {
    
	[[UIApplication sharedApplication] beginIgnoringInteractionEvents];
	
       parentView			= [[UIView alloc]initWithFrame:CGRectMake(100, 200, 120, 120)];

       parentView.layer.cornerRadius = 6.0;
	UIWindow *window	= [[UIApplication sharedApplication] keyWindow];
	parentView.center	= window.center;
	[parentView setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8]];
	
	[parentView addSubview:self];
	[window addSubview:parentView];
}
// Hides the view
- (void) hideView
{
	[parentView removeFromSuperview];
	parentView = nil;
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    [MailClassViewController addTransitionAnimationOfType:kCATransitionFade forLayer:[[[UIApplication sharedApplication] keyWindow] layer] forDuration:0.30 onTarget:nil];
    
}
#pragma mark PRIVATE METHODS

// Creates the view
- (void)prepareView
{
	[self setBackgroundColor:[UIColor clearColor]];
	[self setUserInteractionEnabled:YES];
	UIActivityIndicatorView *progressIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(45, 25, 30, 30)];
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 70, 80, 30)];

	[progressIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
	[progressIndicator startAnimating];
	[self addSubview:progressIndicator];
	messageLabel.font = [UIFont fontWithName:@"QuicksandsandBook Regular" size:15.0f];
	[messageLabel setTextColor:[UIColor whiteColor]];
	[messageLabel setBackgroundColor:[UIColor clearColor]];
	messageLabel.text = message;
	messageLabel.textAlignment = NSTextAlignmentCenter;
	[self addSubview:messageLabel];
}



@end
