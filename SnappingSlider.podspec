Pod::Spec.new do |s|
  s.name         = "SnappingSlider"
  s.version      = "1.0.2"
  s.summary      = "A beautiful slider control for iOS built purely upon Swift."
  s.description  = <<-DESC
                   A slider control built upon UIKitDynamic using Swift. Simple and effecient. 
                   DESC
  s.homepage     = "https://github.com/rehatkathuria/SnappingSlider"
  s.screenshots  = "http://i.imgur.com/D6IsT2r.gif"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Rehat Kathuria" => "rehat.k@gmail.com" }
  s.social_media_url   = "http://twitter.com/itskathuria"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/rehatkathuria/SnappingSlider.git", :tag => s.version}
  s.source_files  = "SnappingSlider/SnappingSlider.swift"
  s.requires_arc = true
end
