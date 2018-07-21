require 'rack'
require_relative 'presentation'

use Rack::Static, urls: ['/public']

presentation = proc do |env|
  Presentation.new('ruby').call
end

run presentation