//
//  UMImageView.h
//  UMImageView
//
//  Created by Shaun Harrison on 9/15/09.
//  Copyright (c) 2009-2010 enormego
//  Modifyed by Umeng on 6/6/12
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <UIKit/UIKit.h>
#import "UMImageLoader.h"

typedef enum
{
    UMImageView_Init,
    UMImageView_Success,
    UMImageView_Failed,
}UMImageView_Status;

@interface UMAnimatedGifFrame : NSObject
{
	NSData *data;
	NSData *header;
	double delay;
	int disposalMethod;
	CGRect area;
}

@property (nonatomic, copy) NSData *header;
@property (nonatomic, copy) NSData *data;
@property (nonatomic) double delay;
@property (nonatomic) int disposalMethod;
@property (nonatomic) CGRect area;
@end


@protocol UMImageViewDelegate;
@interface UMImageView : UIImageView<UMImageLoaderObserver> {
@private
	NSURL* imageURL;
	UIImage* placeholderImage;
	id<UMImageViewDelegate> delegate;
    
    //add for status
    UMImageView_Status _status;
    BOOL _isGif;
    
    //for gif
    NSData *GIF_pointer;
	NSMutableData *GIF_buffer;
	NSMutableData *GIF_screen;
	NSMutableData *GIF_global;
	NSMutableArray *GIF_frames;
	
	int GIF_sorted;
	int GIF_colorS;
	int GIF_colorC;
	int GIF_colorF;
	
	int dataPointer;
}
@property(nonatomic,retain) NSURL* imageURL;
@property(nonatomic,retain) UIImage* placeholderImage;
@property(nonatomic,assign) id<UMImageViewDelegate> delegate;

@property   UMImageView_Status status;
@property   BOOL             isGif;


- (id) initWithPlaceholderImage:(UIImage*)anImage; // delegate:nil
- (id) initWithPlaceholderImage:(UIImage*)anImage delegate:(id<UMImageViewDelegate>)aDelegate;
- (void) cancelImageLoad;
- (void) startAnimating;
- (void) setCacheSecondes:(NSTimeInterval)secondes;

//for gif
- (void) decodeGIF:(NSData *)GIF_Data;
- (void) GIFReadExtensions;
- (void) GIFReadDescriptor;
- (bool) GIFGetBytes:(int)length;
- (bool) GIFSkipBytes: (int) length;
- (NSData*) getFrameAsDataAtIndex:(int)index;
- (UIImage*) getFrameAsImageAtIndex:(int)index;
- (void) setAnimationData;
@end

@protocol UMImageViewDelegate<NSObject>
@optional
- (void)imageViewLoadedImage:(UMImageView*)imageView;
- (void)imageViewFailedToLoadImage:(UMImageView*)imageView error:(NSError*)error;
@end