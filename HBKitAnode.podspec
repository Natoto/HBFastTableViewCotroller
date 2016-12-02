Pod::Spec.new do |s|
s.name         = "HBKitAnode"
s.version      = "0.6.33"
s.summary      = "based facebook AsyncDisplayKit for hbkit."
s.homepage     = "https://github.com/Natoto/HBFastTableViewCotroller"
s.license      = "MIT"
s.authors      = { 'nonato ' => '787038442@qq.com'}
s.platform     = :ios,'7.0'
s.source       = { :git => "https://github.com/Natoto/HBFastTableViewCotroller.git", :tag => s.version }
s.source_files = "tools/HBKitAnode/**/*.{h,m}"
s.requires_arc = true 
s.dependency 'HBKit'
s.dependency 'AsyncDisplayKit'
end
