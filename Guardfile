require "base64"

guard 'shell' do
  # builds latex file to pdf and hides output
  watch(/.*\.js/) do |m|
    `cp #{m} $HOME/Dropbox/Public/iol-humanizer/`
  end
  watch(/.*\.haml/) do |m|
  	dump = Base64.strict_encode64 `cat #{m.to_s}`
  	puts dump
  	dump = "window.#{m.to_s.gsub(/\..*/,"").match(/[^\/]*$/).to_s}View = Haml(Base64.decode('#{dump}'));"
    `echo "#{dump}" > $HOME/Dropbox/Public/iol-humanizer/views/#{m.to_s.gsub(/\..*/,"").match(/[^\/]*$/).to_s}.haml.js`
  end
end