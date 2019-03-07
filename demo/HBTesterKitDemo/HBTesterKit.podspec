Pod::Spec.new do |s|
s.name         = "HBTesterKit"
s.version      = "1.0.1"
s.summary      = "A  Fast Style TableViewController."
s.homepage     = "https://github.com/Natoto/HBFastTableViewCotroller"
s.license      = "MIT"
s.authors      = { 'nonato ' => '787038442@qq.com'}
s.platform     = :ios,'7.0'
s.source       = { :git => "https://github.com/Natoto/HBFastTableViewCotroller.git", :tag => s.version }
s.source_files = "HBTesterKit/**/*.{h,m,plist}"
s.requires_arc = true 
end
