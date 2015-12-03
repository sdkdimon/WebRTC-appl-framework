Pod::Spec.new do |s|
  s.name             = "WebRTC_framework"
  s.version          = "10842.2.3"
  s.summary      = "WebRTC is a free, open project that provides browsers and mobile applications with Real-Time Communications capabilities via simple APIs."
  s.homepage         = "https://github.com/sdkdimon/WebRTC-appl-framework"

  s.ios.platform = :ios, '7.0'
  s.osx.platform = :osx, '10.8'
  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.8'

  s.author           = { 'Dmitry Lizin' => 'sdkdimon@gmail.com'}
  s.source           = { :git => "https://github.com/sdkdimon/WebRTC-appl-framework.git", :tag => s.version }

  s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-ObjC' }
  s.requires_arc = true
  s.module_name = 'WebRTC'
  s.ios.vendored_frameworks = 'iOS/WebRTC.framework'
  s.osx.vendored_frameworks = 'OSX/WebRTC.framework'
  s.osx.framework = 'AVFoundation', 'AudioToolbox', 'CoreGraphics', 'CoreMedia', 'GLKit', 'QTKit', 'CoreAudio', 'CoreVideo', 'VideoToolbox'
  s.ios.framework = 'AVFoundation', 'AudioToolbox', 'CoreGraphics', 'CoreMedia', 'GLKit', 'UIKit', 'VideoToolbox'
  s.libraries =  'c', 'sqlite3', 'stdc++'
  s.requires_arc = true
  s.license      = {
    :type => 'http://www.webrtc.org/license-rights/license',
    :text => <<-LICENSE
      Copyright (c) 2011, The WebRTC project authors. All rights reserved.

      Redistribution and use in source and binary forms, with or without
      modification, are permitted provided that the following conditions are
      met:

        * Redistributions of source code must retain the above copyright
          notice, this list of conditions and the following disclaimer.

        * Redistributions in binary form must reproduce the above copyright
          notice, this list of conditions and the following disclaimer in
          the documentation and/or other materials provided with the
          distribution.

        * Neither the name of Google nor the names of its contributors may
          be used to endorse or promote products derived from this software
          without specific prior written permission.

      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
      "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
      LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
      A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
      HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
      SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
      LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
      DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
      THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
      (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
      OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
      LICENSE
  }

end
