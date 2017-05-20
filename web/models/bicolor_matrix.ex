defmodule BicolorMatrix do

  alias ElixirALE.I2C

  @off 0
  @green 1
  @red 2
  @yellow 3

  def initialize() do
    { :ok, pid } = I2C.start_link("i2c-1", 0x70)
    pid
  end

  def release(pid) do
    I2C.release(pid)
  end

  def clear() do
    Enum.each(0..15, fn x -> write(<<x, 0x00>>) end)
  end

  def write(data) do
    pid = initialize()
    I2C.write(pid, data)
    release(pid)
  end

  def draw_target() do
    write(<<0x00, 0xFF>>)

    write(<<0x02, 0xFF>>)
    write(<<0x03, 0x7E>>)

    write(<<0x04, 0xFF>>)
    write(<<0x05, 0x7E>>)

    write(<<0x06, 0xE7>>)
    write(<<0x07, 0x7E>>)

    write(<<0x08, 0xE7>>)
    write(<<0x09, 0x7E>>)
    
    write(<<0x0A, 0xFF>>)
    write(<<0x0B, 0x7E>>)
    
    write(<<0x0C, 0xFF>>)
    write(<<0x0D, 0x7E>>)

    write(<<0x0E, 0xFF>>)
  end

  def draw_green_x() do
    write(<<0x01, 0xFF>>)
    
    write(<<0x02, 0x7E>>)
    write(<<0x03, 0xBD>>)

    write(<<0x04, 0x7E>>)
    write(<<0x05, 0xDB>>)

    write(<<0x06, 0x7E>>)
    write(<<0x07, 0xE7>>)

    write(<<0x08, 0x7E>>)
    write(<<0x09, 0xE7>>)
   
    write(<<0x0A, 0x7E>>)
    write(<<0x0B, 0xDB>>)
     
    write(<<0x0C, 0x7E>>)
    write(<<0x0D, 0xBD>>)

    write(<<0x0F, 0xFF>>)
  end

  def draw_red_dot() do
    write(<< 0x01, 0x18 >>)
    write(<< 0x03, 0x3C >>)
    write(<< 0x05, 0x7E >>)
    write(<< 0x07, 0xFF >>)
    write(<< 0x09, 0xFF >>)
    write(<< 0x0B, 0x7E >>)
    write(<< 0x0D, 0x3C >>)
    write(<< 0x0F, 0x18 >>)
  end

  def draw_green_dot() do
    write(<< 0x00, 0x18 >>)
    write(<< 0x02, 0x3C >>)
    write(<< 0x04, 0x7E >>)
    write(<< 0x06, 0xFF >>)
    write(<< 0x08, 0xFF >>)
    write(<< 0x0A, 0x7E >>)
    write(<< 0x0C, 0x3C >>)
    write(<< 0x0E, 0x18 >>)
  end

  def draw_yellow_dot() do
    draw_red_dot()
    draw_green_dot()
  end

  def draw_christmas_checkers() do
    write(<< 0x00, 0xAA >>)
    write(<< 0x01, 0x55 >>)
    
    write(<< 0x03, 0xAA >>)
    write(<< 0x02, 0x55 >>)

    write(<< 0x04, 0xAA >>)
    write(<< 0x05, 0x55 >>)

    write(<< 0x07, 0xAA >>)
    write(<< 0x06, 0x55 >>)

    write(<< 0x08, 0xAA >>)
    write(<< 0x09, 0x55 >>)

    write(<< 0x0B, 0xAA >>)
    write(<< 0x0A, 0x55 >>)

    write(<< 0x0C, 0xAA >>)
    write(<< 0x0D, 0x55 >>)

    write(<< 0x0F, 0xAA >>)
    write(<< 0x0E, 0x55 >>)
  end

  def draw_random() do
    drawings = {
      &draw_target/0,
      &draw_green_x/0,
      &draw_green_dot/0,
      &draw_red_dot/0,
      &draw_yellow_dot/0,
      &draw_christmas_checkers/0
    }

    index = :rand.uniform(tuple_size(drawings)) - 1

    clear()
    elem(drawings, index).()
  end

end
