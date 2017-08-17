Pod::Spec.new do |s|
  s.name             = 'RadarChartView'
  s.version          = '1.0.0'
  s.summary          = 'RadarChart for iOS'
  s.homepage         = 'https://github.com/furuyan/RadarChartView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'furuyan' => 'kfuruyan@gmail.com' }
  s.source           = { :git => 'https://github.com/furuyan/RadarChartView.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'RadarChartView/Classes/**/*'
end
