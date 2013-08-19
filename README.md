# CKShapeView

CKShapeView is a `UIView` subclass that is backed by a `CAShapeLayer`.

In other words, it is a view that is capable of rendering an arbitrary `CGPath`.

It is completely configurable **and animatable**, so you can have custom drawn views without needing to subclass.

`CKShapeView` has all of the properties of `CAShapeLayer`, with the addition of a `hitTestUsingPath` property that allows you to hit test using the path instead of the view's bounds.

## Example Usage

``` objc
CKShapeView *pieView = [[CKShapeView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
CGFloat width = CGRectGetWidth(pieView.bounds);
pieView.path = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(pieView.bounds, width/4, width/4)];
pieView.lineWidth = width/2;
pieView.fillColor = nil;
pieView.strokeColor = [UIColor blackColor];
[self.view addSubview:pieView];

UIViewAnimationOptions options = UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat;
[UIView animateWithDuration:1.0f delay:0.0f options:options animations:^{
    pieView.strokeEnd = 0.0f;
} completion:nil];
```

![Example](https://raw.github.com/conradev/CKShapeView/screenshots/Example.gif)

## License

CKShapeView is available under the MIT license. See the LICENSE file for more info.
