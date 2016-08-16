Pod::Spec.new do |s|
s.name         = "MLEmojiLabel"
s.version      = "1.0.2"
s.summary      = "Autolink @,#xx#,phone,website,email and custom expression for TTTAttributedLabel."

s.homepage     = 'https://github.com/molon/MLEmojiLabel'
s.license      = { :type => 'MIT'}
s.author       = { "molon" => "dudl@qq.com" }

s.source       = {
:git => "https://github.com/molon/MLEmojiLabel.git",
:tag => "#{s.version}"
}

s.platform     = :ios, '6.0'
s.public_header_files = 'Classes/**/*.h'
s.source_files  = 'Classes/**/*.{h,m}'
s.resource = "Classes/**/*.{bundle,plist}"
s.requires_arc  = true

s.dependency 'TTTAttributedLabel', '~> 1.13.4'

end
