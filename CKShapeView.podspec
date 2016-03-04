Pod::Spec.new do |s|
  s.name     = 'CKShapeView'
  s.version  = '0.1.3'
  s.license  = 'MIT'
  s.summary  = 'UIView subclass that is backed by CAShapeLayer'
  s.homepage = 'https://github.com/conradev/CKShapeView'
  s.author   = { 'Conrad Kramer' => 'conrad@kramerapps.com' }
  s.source   = { :git => 'https://github.com/conradev/CKShapeView.git',
                 :tag => '0.1.3' }
  s.source_files = 'CKShapeView'
  s.requires_arc = true
  s.platform = :ios, '4.3'
  s.frameworks = 'UIKit', 'QuartzCore'
end
