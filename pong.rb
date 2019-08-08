require 'ruby2d'

# Set the window size
set width: 600, height: 600
@score1 = 0 
@score2 = 0 
# Create a new shape
@score1Text = Text.new(
  @score1,
  x: 245, y: 50,
  font: 'vera.ttf',
  size: 50,
  color: 'red',
  rotate: 0,
  z: 10
)

@score2Text = Text.new(
  @score2,
  x: 345, y: 50,
  font: 'vera.ttf',
  size: 50,
  color: 'green',
  rotate: 0,
  z: 10
)

@ball = Square.new(x: 300, y: 300, size: 20, color: 'blue')
@paddle_board1 = Rectangle.new(
  x: 50, 
  y: 300, 
  width: 10, 
  height: 60, 
  color: 'red')
@paddle_board2 = Rectangle.new(
  x: 550, 
  y: 300, 
  width: 10, 
  height: 60, 
  color: 'green')
#gamecode goes under here
paddle_speed = 5 

on :key_held do |event|
  case event.key 
  when 's'
    if (@paddle_board1.y + @paddle_board1.height) < 600
      @paddle_board1.y += paddle_speed 
    end 
  when 'w'
    if @paddle_board1.y > 0
      @paddle_board1.y -= paddle_speed
    end 
  when 'down'
    if (@paddle_board2.y + @paddle_board2.height) < 600
      @paddle_board2.y += paddle_speed
    end 
  when 'up'
    if @paddle_board2.y > 0
      @paddle_board2.y -= paddle_speed
    end 
  end
end

@x_velocity = 3
@y_velocity = 2

def reset_ball 
  @x_velocity = 3
  @y_velocity = 2
  @ball.y = 300 
  @ball.x = 300
end 

tick = 0
reset_ball() 

def paddle_board1_collision 
  if @ball.x <= (@paddle_board1.x + @paddle_board1.width) &&
    @ball.x >= @paddle_board1.x &&
    (@ball.y + @ball.height) >= @paddle_board1.y && 
    @ball.y <= (@paddle_board1.y + @paddle_board1.height)
    return true 
  else 
    return false 
  end 
end 

def paddle_board2_collision 
  if 
    (@ball.x + @ball.width) >= @paddle_board2.x && 
    (@ball.x + @ball.width) <= (@paddle_board2.x + @paddle_board2.width) &&
    (@ball.y + @ball.height) >= @paddle_board2.y && 
    @ball.y <= (@paddle_board2.y + @paddle_board2.height)
    return true 
  else 
    return false 
  end 
end 

update do
  @ball.x += @x_velocity
  @ball.y += @y_velocity
  tick += 1
  if ((@ball.y + @ball.height) >= 600) && @y_velocity >= 1 
    @y_velocity = @y_velocity * -1 
  elsif (@ball.y <= 0) && @y_velocity < 0
    @y_velocity = @y_velocity * -1
  end 
  if ((@ball.x + @ball.width) >= 600) && @x_velocity >= 1
    @score1 += 1
    @score1Text.text = @score1
    reset_ball()
  elsif (@ball.x <= 0) && @x_velocity < 0 
    @score2 += 1
    @score2Text.text = @score2 
    reset_ball() 
  end 
  if paddle_board1_collision || paddle_board2_collision
    @x_velocity = @x_velocity * -1
    @x_velocity = @x_velocity * 1.1 

  end 
end

# Show the window
show