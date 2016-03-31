Pod::Spec.new do |s|
s.name         = "HBKit"
s.version      = "0.5.2"
s.summary      = "A  Fast Style TableViewController."
s.homepage     = "https://github.com/Natoto/HBFastTableViewCotroller"
s.license      = "MIT"
s.authors      = { 'nonato ' => '787038442@qq.com'}
s.platform     = :ios, "6.0"
s.source       = { :git => "https://github.com/Natoto/HBFastTableViewCotroller.git", :tag => s.version }
s.source_files = "HBKit/**/*.{h,m,plist}"
s.requires_arc = true
s.dependency "MJRefresh", "~> 2.2.0"
end
