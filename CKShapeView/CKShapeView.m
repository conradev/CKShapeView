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

- (BOOL)shouldForwardSelector:(SEL)aSelector {
    return (![[self.layer superclass] instancesRespondToSelector:aSelector] &&
            [self.layer respondsToSelector:aSelector]);
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return (![self respondsToSelector:aSelector] && [self shouldForwardSelector:aSelector]) ? self.layer : self;
}

- (void)setPath:(UIBezierPath *)path {
    self.layer.path = path.CGPath;
    self.layer.fillRule = path.usesEvenOddFillRule ? kCAFillRuleEvenOdd : kCAFillRuleNonZero;
    self.layer.lineWidth = path.lineWidth;
    self.layer.miterLimit = path.miterLimit;

    switch (path.lineCapStyle) {
        case kCGLineCapButt:
            self.layer.lineCap = kCALineCapButt;
            break;
        case kCGLineCapRound:
            self.layer.lineCap = kCALineCapRound;
            break;
        case kCGLineCapSquare:
            self.layer.lineCap = kCALineCapSquare;
            break;
    }

    switch (path.lineJoinStyle) {
        case kCGLineJoinMiter:
            self.layer.lineJoin = kCALineJoinMiter;
            break;
        case kCGLineJoinRound:
            self.layer.lineJoin = kCALineJoinRound;
            break;
        case kCGLineJoinBevel:
            self.layer.lineJoin = kCALineJoinBevel;
            break;
    }

    NSInteger count;
    [path getLineDash:NULL count:&count phase:NULL];
    CGFloat pattern[count], phase;
    [path getLineDash:pattern count:NULL phase:&phase];

    NSMutableArray *lineDashPattern = [NSMutableArray array];
    for (NSUInteger i = 0; i < count; i++) {
        [lineDashPattern addObject:@(pattern[i])];
    }

    self.layer.lineDashPattern = [lineDashPattern copy];
    self.layer.lineDashPhase = phase;
}

- (UIBezierPath *)path {
    UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:self.layer.path];
    path.lineWidth = self.layer.lineWidth;
    path.usesEvenOddFillRule = (self.layer.fillRule == kCAFillRuleEvenOdd);
    path.lineWidth = self.layer.lineWidth;
    path.miterLimit = self.layer.miterLimit;

    NSString *lineCap = self.layer.lineCap;
    if ([lineCap isEqualToString:kCALineCapButt]) {
        path.lineCapStyle = kCGLineCapButt;
    } else if ([lineCap isEqualToString:kCALineCapRound]) {
        path.lineCapStyle = kCGLineCapRound;
    } else if ([lineCap isEqualToString:kCALineCapSquare]) {
        path.lineCapStyle = kCGLineCapSquare;
    }

    NSString *lineJoin = self.layer.lineJoin;
    if ([lineJoin isEqualToString:kCALineJoinMiter]) {
        path.lineJoinStyle = kCGLineJoinMiter;
    } else if ([lineJoin isEqualToString:kCALineJoinRound]) {
        path.lineJoinStyle = kCGLineJoinRound;
    } else if ([lineJoin isEqualToString:kCALineJoinBevel]) {
        path.lineJoinStyle = kCGLineJoinBevel;
    }

    CGFloat phase = self.layer.lineDashPhase;
    NSInteger count = self.layer.lineDashPattern.count;
    CGFloat pattern[count];
    for (NSUInteger i = 0; i < count; i++) {
        pattern[i] = [[self.layer.lineDashPattern objectAtIndex:i] floatValue];
    }

    [path setLineDash:pattern count:count phase:phase];
    
    return path;
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

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL inside = [super pointInside:point withEvent:event];
    return self.hitTestUsingPath ? [self.path containsPoint:point] && inside : inside;
}

// This is a cleaner way of enabling animation, but it involves using a private API :(

//- (BOOL)_shouldAnimatePropertyWithKey:(NSString *)key {
//    return ([self shouldForwardSelector:NSSelectorFromString(key)] || [super _shouldAnimatePropertyWithKey:key]);
//}

- (id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)key {
    id<CAAction> action = [super actionForLayer:layer forKey:key];

    if ([layer isEqual:self.layer] && [[NSNull null] isEqual:action]) {
        if ([self shouldForwardSelector:NSSelectorFromString(key)]) {
            CABasicAnimation *animation = (CABasicAnimation *)[self actionForLayer:layer forKey:@"bounds"];
            if ([animation isKindOfClass:[CABasicAnimation class]]) {
                animation.fromValue = [layer valueForKey:key];
                animation.keyPath = key;
                action = animation;
            }
        }
    }

    return action;
}

@end
