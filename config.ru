require 'rack'
require_relative 'presentation'
require_relative 'sass'

Sass.compile!

use Rack::Static, urls: ['/public']

presentation = proc do |env|
  Presentation.new('ruby').call
end

run presentation