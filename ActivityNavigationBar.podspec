#
# Be sure to run `pod lib lint ActivityNavigationBar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ActivityNavigationBar'
  s.version          = '1.0'
  s.summary          = 'Navigation bar with a progress bar-style activity indicator written in Swift'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Activity navigation bar provides a custom navigation bar with a build in
  activity indicator. The activity indicator is styled like a progress bar,
  but is intended to be used to indicate indeterminate activity time.

  To achieve this, the activity is started with a 'waitAt' parameter.
  The activity bar will then animate progress to this point, and stop.
  Then, once our indeterminate activity has finished, we finish the
  activity indicator.
                       DESC

  s.homepage         = 'https://github.com/superpeteblaze/ActivityNavigationBar'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Pete Smith' => 'peadar81@gmail.com' }
  s.source           = { :git => 'https://github.com/superpeteblaze/ActivityNavigationBar.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/superpeteblaze'

  s.platform = :ios
  s.ios.deployment_target = '9.0'

  s.source_files = 'ActivityNavigationBar/Classes/**/*'

end
