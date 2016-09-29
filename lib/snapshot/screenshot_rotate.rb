require 'shellwords'

module Snapshot
  # This class takes care of rotating images
  class ScreenshotRotate
    # @param (String) The path in which the screenshots are located in
    def run(path)
      UI.current.log.debug "Rotating the screenshots (if necessary)"
      rotate(path)
    end

    def rotate(path)
      Dir.glob([path, '/**/*.png'].join('/')).each do |file|
        UI.current.log.debug "Rotating '#{file}'" if $verbose

        command = nil
        if file.end_with? "landscapeleft.png"
          command = "sips -r -90 '#{file}'"
        elsif file.end_with? "landscaperight.png"
          command = "sips -r 90 '#{file}'"
        elsif file.end_with? "portrait_upsidedown.png"
          command = "sips -r 180 '#{file}'"
        end

        # Only rotate if we need to
        if command
          PTY.spawn( command ) do |r, w, pid|
            r.sync
            r.each do |line|
              # We need to read this otherwise things hang
            end
            ::Process.wait pid
          end
        end

      end
    end

  end
end
