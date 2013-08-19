//
//  CKShapeView.m
//  CKShapeView
//
//  Created by Conrad Kramer on 8/19/13.
//  Copyright (c) 2013 Kramer Software Productions, LLC. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "CKShapeView.h"

//@interface UIView (Private)
//
//- (BOOL)_shouldAnimatePropertyWithKey:(NSString *)key;
//
//@end

@interface CKShapeView ()

@property CAShapeLayer *layer;

@end

@implementation CKShapeView

@dynamic path, fillColor, fillRule, strokeColor, strokeStart, strokeEnd, lineWidth, miterLimit, lineCap, lineJoin, lineDashPhase, lineDashPattern;

+ (Class)layerClass {
    return [CAShapeLayer class];
}

#pragma mark - Properties

- (BOOL)shouldForwardSelector:(SEL)aSelector {
    return (![[self.layer superclass] instancesRespondToSelector:aSelector] &&
            [self.layer respondsToSelector:aSelector]);
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return (![self respondsToSelector:aSelector] && [self shouldForwardSelector:aSelector]) ? self.layer : self;
}

- (void)setPath:(UIBezierPath *)path {
    self.layer.path = path.CGPath;
}

- (UIBezierPath *)path {
    return [UIBezierPath bezierPathWithCGPath:self.layer.path];
}

- (void)setFillColor:(UIColor *)fillColor {
    self.layer.fillColor = fillColor.CGColor;
}

- (UIColor *)fillColor {
    return [UIColor colorWithCGColor:self.layer.fillColor];
}

- (void)setStrokeColor:(UIColor *)strokeColor {
    self.layer.strokeColor = strokeColor.CGColor;
}

- (UIColor *)strokeColor {
    return [UIColor colorWithCGColor:self.layer.strokeColor];
}

#pragma mark - Animation

// This is a cleaner way of doing things, but it involves using a private API :(

//- (BOOL)_shouldAnimatePropertyWithKey:(NSString *)key {
//    return ([self shouldForwardSelector:NSSelectorFromString(key)] || [super _shouldAnimatePropertyWithKey:key]);
//}

- (id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)key {
    id<CAAction> action = [super actionForLayer:layer forKey:key];

    if ([layer isEqual:self.layer] && [[NSNull null] isEqual:action]) {
        if ([self shouldForwardSelector:NSSelectorFromString(key)]) {
            CABasicAnimation *animation = (CABasicAnimation *)[layer actionForKey:@"bounds"];
            animation.fromValue = nil;
            animation.toValue = nil;
            animation.byValue = nil;
            animation.keyPath = key;
            action = animation;
        }
    }

    return action;
}

@end
