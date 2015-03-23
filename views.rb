class View

  def self.layout
"
<html>
  <head>
    <title>Super Title</title>
  </head>
  <body>
    #{yield}
  </body>
</html>
"
  end

  def self.welcome
    layout {"Hello World"}
  end

  def self.profile
    layout {"Matt Baker"}
  end
end