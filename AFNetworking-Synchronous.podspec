Pod::Spec.new do |s|
  s.name         = 'AFNetworking-Synchronous'
  s.version      = '1.0.0'
  s.summary      = 'Synchronous requests for AFNetworking'
  s.description  = <<-DESC
                   A minimal category which extends AFNetworking to support synchronous
                   requests. Supports AFNetworking 1.x or 2.x.
                   DESC
  s.homepage     = 'https://github.com/paulmelnikow/AFNetworking-Synchronous'
  s.license      = 'MIT'
  s.author       = { "Paul Melnikow" => "github@paulmelnikow.com" }
  s.source       = { :git => 'https://github.com/paulmelnikow/AFNetworking-Synchronous.git',
                     :tag => "v#{s.version}" }

  s.ios.deployment_target = '6.0'
  s.requires_arc = true

  s.subspec '1.x' do |sp|
    s.osx.deployment_target = '10.7'
    sp.source_files = '1.x'
    sp.dependency 'AFNetworking', '~> 1.0'
  end

  s.subspec '2.x' do |sp|
    s.osx.deployment_target = '10.8'
    sp.source_files = '2.x'
    sp.dependency 'AFNetworking', '~> 2.0'
  end

  s.default_subspec = '2.x'

end
