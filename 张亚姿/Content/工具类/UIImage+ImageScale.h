//
//  UIImage+ImageScale.h
//  PanliApp
//
//  Created by Liubin on 14-3-28.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageScale)

-(UIImage*)getSubImage:(CGRect)rect;
-(UIImage*)scaleWithRadioSize:(CGSize)size;
-(UIImage*)scaleByWidth:(float)iWidth;
-(UIImage*)scaleToFullWidthSize;
-(UIImage*)scaleToSize:(CGSize)newSize;
- (UIImage *)imageCompressed;
- (UIImage *)imageByScalingToMaxSize;
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize isWhithSpace:(BOOL)isWhiteSpace;
@end
