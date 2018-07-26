def compile_sass!
  system 'sass sass/index.scss:public/css/index.css'
rescue
  nil
end
