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
      "<div class='slide'>#{slide}</div>"
    end.join("\n")
  end

  def html
    <<~HTML
      <html>
        <head>
          <title>My Presentation</title>
        </head>

        <body>
          #{format_slides}

          <script src='https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js'></script>
          <script src='slick/slick.min.js'></script>

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