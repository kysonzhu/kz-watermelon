Pod::Spec.new do |s|
s.name = 'Watermelon'
s.version = '1.0.2'
s.license = 'MIT'
s.summary = 'A Hybrid solution on iOS.'
s.homepage = 'https://github.com/kysonzhu/kz-watermelon'
s.authors = { 'kysonzhu' => 'zjh171@gmail.com' }
s.source = { :git => 'https://github.com/kysonzhu/kz-watermelon.git', :tag => s.version.to_s }
s.requires_arc = true
s.ios.deployment_target = '8.0'
s.source_files = 'Watermelon/watermelon/**/*.{h,m}'
s.resources = 'Watermelon/watermelon/*.{png}'
end
