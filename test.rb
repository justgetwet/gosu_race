class Geko
  def gee
    p "gee"
  end
  def goko
    p "geko"
  end
end

p = Geko.new
method_name = "gee"
p.send(method_name)