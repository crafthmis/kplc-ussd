require "vcr"

VCR.configure do |c|  
  #the directory where your cassettes will be saved
  #c.ignore_hosts '127.0.0.1', 'localhost','http://lvh.me/','http://*.lvh.me'
  c.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  # your HTTP request service. 
  c.hook_into :webmock
end  



