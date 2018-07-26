# Load the Rack Gem
require 'rack'

# Load the Presentation class
require_relative 'presentation'

# Load the compile_sass! function
require_relative 'sass'

# Compile my sass into css.
compile_sass!

# Set the "/public" subfolder as a static directory, so css and javascript can be fetched without hitting the web server.
use Rack::Static, urls: ['/public']

# Create a new presentation proc that takes a rack environment and generates a new presentation object.
presentation = proc do |env|

  # Create a presentation object, fetching slides from the "/ruby" subfolder and then call it to convert it to HTML.
  Presentation.new('ruby').call
end

# Run the presentation proc.
run presentation