require 'snapshot/version'
require 'snapshot/snapshot_config'
require 'snapshot/runner'
require 'snapshot/builder'
require 'snapshot/snapshot_file'
require 'snapshot/reports_generator'
require 'snapshot/screenshot_flatten'
require 'snapshot/screenshot_rotate'
require 'snapshot/simulators'
require 'snapshot/dependency_checker'
require 'snapshot/latest_ios_version'

require 'fastlane_core'

module Snapshot
  Helper = FastlaneCore::Helper # you gotta love Ruby: Helper.* should use the Helper class contained in FastlaneCore
  UI = FastlaneCore::UI
  
  Snapshot::DependencyChecker.check_dependencies

  def self.xcode_version
    `xcodebuild -version`.match(/Xcode (.*)/)[1]
  end

  def self.min_xcode7?
    xcode_version.split(".").first.to_i >= 7
  end
end
