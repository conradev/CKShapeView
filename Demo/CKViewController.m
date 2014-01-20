//
//  CKViewController.m
//  Demo
//
//  Created by Conrad Kramer on 1/20/14.
//  Copyright (c) 2014 Conrad Kramer. All rights reserved.
//

#import "CKViewController.h"
#import "CKShapeView.h"

@interface CKViewController ()

@property (weak, nonatomic) CKShapeView *pieView;

@end

@implementation CKViewController

- (void)loadView {
    [super loadView];

    self.view.backgroundColor = [UIColor whiteColor];

    CKShapeView *pieView = [[CKShapeView alloc] init];
    pieView.fillColor = nil;
    pieView.strokeColor = [UIColor blackColor];
    pieView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:pieView];
    self.pieView = pieView;

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pieView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:pieView attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pieView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:250]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pieView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pieView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0]];
}

- (void)viewDidLoad {
    UIViewAnimationOptions options = UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat;
    [UIView animateWithDuration:1.0f delay:0.0f options:options animations:^{
        self.pieView.strokeEnd = 0.0f;
    } completion:nil];
}

- (void)viewDidLayoutSubviews {
    CGFloat width = CGRectGetWidth(self.pieView.bounds);
    self.pieView.path = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.pieView.bounds, width/4, width/4)];
    self.pieView.lineWidth = width/2;
}

@end
