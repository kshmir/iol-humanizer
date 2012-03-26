require "base64"

guard 'shell' do
  watch(/.*\.js/) do |m|
    `cp #{m} bin/`
  end
  watch(/.*\.haml/) do |m|
  	dump = Base64.strict_encode64 `cat #{m.to_s}`
  	puts dump
  	dump = "window.#{m.to_s.gsub(/\..*/,"").match(/[^\/]*$/).to_s}View = Haml(Base64.decode('#{dump}'));"
    `echo "#{dump}" > bin/views/#{m.to_s.gsub(/\..*/,"").match(/[^\/]*$/).to_s}.haml.js`
  end
end

guard 'sprockets', :destination => "bin", :asset_paths => ['src/js/'], root_file: "app.js" do
  watch (%r{src/js/.*.coffee})
  
end

guard 'sprockets', :destination => "bin", :asset_paths => ['src/css'], root_file: "app.css" do
  watch (%r{src/css/.*.sass})
end

