/*
 ******************************************************************************
 Copyright (c) 2016, Sheela Foam Pvt Ltd All rights reserved.
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 *
 *****************************************************************************/

#import "GreatPlusBarCodeScanner.h"
#import <UIKit/UIKit.h>

@interface GreatPlusBarCodeScanner() 

@property (nonatomic, strong) AVMetadataMachineReadableCodeObject *metadataObject;
@property (nonatomic, strong) NSString * barcodeType;
@property (nonatomic, strong) NSString * barcodeData;
@property (nonatomic, strong) UIBezierPath *cornersPath;
@property (nonatomic, strong) UIBezierPath *boundingBoxPath;

@end
@implementation GreatPlusBarCodeScanner

+ (GreatPlusBarCodeScanner * )processMetadataObject: (AVMetadataMachineReadableCodeObject*)code
{
    // 1 create the obj
    GreatPlusBarCodeScanner * barcode=[[GreatPlusBarCodeScanner alloc]init];
    // 2 store code type and string
    barcode.barcodeType = [NSString stringWithString:code.type];
    barcode.barcodeData = [NSString stringWithString:code.stringValue];
    barcode.metadataObject = code;
    // 3 & 4 Create the path joining code's corners
    CGMutablePathRef cornersPath = CGPathCreateMutable();
    // 5 Make point
    CGPoint point;
    CGPointMakeWithDictionaryRepresentation(
                                            (CFDictionaryRef)code.corners[0], &point);
    // 6 Make path
    CGPathMoveToPoint(cornersPath, nil, point.x, point.y);
    // 7
    for (int i = 1; i < code.corners.count; i++) {
        CGPointMakeWithDictionaryRepresentation(
                                                (CFDictionaryRef)code.corners[i], &point);
        CGPathAddLineToPoint(cornersPath, nil,
                             point.x, point.y);
    }
    // 8 Finish box
    CGPathCloseSubpath(cornersPath);
    // 9 Set path
    barcode.cornersPath =
    [UIBezierPath bezierPathWithCGPath:cornersPath];
    CGPathRelease(cornersPath);
    // Create the path for the code's bounding box
    // 10
    barcode.boundingBoxPath =
    [UIBezierPath bezierPathWithRect:code.bounds];
    // 11 return
    return barcode;
    
}
- (NSString *) getBarcodeType{
    return self.barcodeType;
}
- (NSString *) getBarcodeData{
    return self.barcodeData;
}
- (void) printBarcodeData{
    NSLog(@"Barcode of type: %@ and data: %@",self.metadataObject.type, self.barcodeData);
}
@end
