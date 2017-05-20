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
end
