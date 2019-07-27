require 'ruby2d'

# Set the window size
set width: 600, height: 600

# Create a new shape
s = Square.new

# Give it some color
s.color = 'red'

#gamecode goes under here
tick = 0

update do
  if tick % 60 == 0
    set background: 'random'
  end
  tick += 1
end

# Show the window
show