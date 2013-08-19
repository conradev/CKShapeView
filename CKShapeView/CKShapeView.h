//
//  CKShapeView.h
//  CKShapeView
//
//  Created by Conrad Kramer on 8/19/13.
//  Copyright (c) 2013 Kramer Software Productions, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CKShapeView : UIView

@property BOOL hitTestUsingPath;

@property (copy) UIBezierPath *path;

@property UIColor *fillColor;

@property (copy) NSString *fillRule;

@property UIColor *strokeColor;

@property CGFloat strokeStart, strokeEnd;

@property CGFloat lineWidth;

@property CGFloat miterLimit;

@property (copy) NSString *lineCap;

@property (copy) NSString *lineJoin;

@property CGFloat lineDashPhase;

@property (copy) NSArray *lineDashPattern;

@end
