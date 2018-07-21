class Presentation
  def initialize(folder)
    @slides = []
    generate_slides(folder)
  end

  def call
    [200, { "Content-Type" => "text/html" }, [html]]
  end

  private

  def generate_slides(folder)
    Dir["slides/#{folder}/*.html"].sort.each { |f| load_slide(f) }
  end

  def load_slide(file)
    @slides << File.read(file)
  end

  def format_slides
    @slides.map do |slide|
      "<article class='slide'>#{slide}</article>"
    end.join("\n")
  end

  def wrap_slides
    "<main class='presentation'>#{format_slides}</main>"
  end

  STYLESHEETS = [
    "public/slick/slick.css",
    "public/slick/slick-theme.css",
    "//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/styles/default.min.css",
    "public/css/index.css"
  ]

  def stylesheets
    STYLESHEETS.map { |href| "<link rel='stylesheet' type='text/css' href='#{href}'>" }.join("\n")
  end

  def html
    <<~HTML
      <html>
        <head>
          <title>My Presentation</title>
          #{stylesheets}
        </head>

        <body>
          #{wrap_slides}

          <script src='https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js'></script>
          <script src='public/slick/slick.min.js'></script>

          <script src="//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/highlight.min.js"></script>

          <script>hljs.initHighlightingOnLoad();</script>

          <script type="text/javascript">
            $(document).ready(function(){
              $('.presentation').slick();
            });
          </script>
        </body>
      </html>
    HTML
  end
end