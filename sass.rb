module Sass
  module_function

  def compile!
    system 'sass sass/index.scss:public/css/index.css'
  end
end