Pod::Spec.new do |s|
  s.name         = 'AFNetworking-Synchronous'
  s.version      = '2.0.0-dev'
  s.summary      = 'Synchronous requests for AFNetworking'
  s.description  = <<-DESC
                   A minimal category which extends AFNetworking to support synchronous
                   requests. Supports AFNetworking 1.x, 2.x, 3.x, and 4.x.
                   DESC
  s.homepage     = 'https://github.com/paulmelnikow/AFNetworking-Synchronous'
  s.license      = 'MIT'
  s.author       = { "Paul Melnikow" => "github@paulmelnikow.com" }
  s.source       = { :git => 'https://github.com/paulmelnikow/AFNetworking-Synchronous.git',
                     :tag => "#{s.version}" }

  s.requires_arc = true

  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.9'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'
  
  s.subspec '4.x' do |sp|
    sp.source_files = '4.x/*.{h,m}'
    sp.dependency 'AFNetworking', '~> 4.0'
  end

  s.subspec '3.x' do |sp|
    sp.source_files = '3.x/*.{h,m}'
    sp.dependency 'AFNetworking', '~> 3.0'
  end

  s.subspec '2.x' do |sp|
    sp.ios.deployment_target = '6.0'
    sp.osx.deployment_target = '10.8'
    sp.source_files = '2.x/*.{h,m}'
    sp.dependency 'AFNetworking', '~> 2.0'
  end

  s.subspec '1.x' do |sp|
    sp.ios.deployment_target = '6.0'
    sp.osx.deployment_target = '10.7'
    sp.source_files = '1.x/*.{h,m}'
    sp.dependency 'AFNetworking', '~> 1.0'
  end

  s.default_subspec = '3.x'

end
