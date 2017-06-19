defmodule BicolorMatrix do

  alias ElixirALE.I2C

  use Bitwise

  @off 0
  @green 1
  @red 2
  @yellow 3

  def initialize() do
    pid = start()
    I2C.write(pid, <<0x21, 0x00>>)
    I2C.write(pid, <<0x81, 0x00>>)
    release(pid)
  end

  def release(pid) do
    I2C.release(pid)
  end

  def clear() do
    pid = start()
    Enum.each(0..15, fn x -> write(pid, <<x, 0x00>>) end)
    release(pid)
  end

  def draw_index(index) do
    drawings = drawings()
    clear()
    case index do
      i when i in 0..tuple_size(drawings) - 1 -> elem(drawings, i).()
      o when o == -2 -> clear()
      _ -> draw_random()
    end
  end

  def set_brightness(brightness) do
    unless brightness < 0 || brightness > 15 do
      pid = start()
      I2C.write(pid, <<bor(0xE0, brightness)>>)
      release(pid)
    end
  end

  defp start() do
    { :ok, pid } = I2C.start_link("i2c-1", 0x70)
    pid
  end

  defp write(pid, data) do
    I2C.write(pid, data)
  end

  def draw_target() do
    pid = start()

    write(pid, <<0x00, 0xFF>>)

    write(pid, <<0x02, 0xFF>>)
    write(pid, <<0x03, 0x7E>>)

    write(pid, <<0x04, 0xFF>>)
    write(pid, <<0x05, 0x7E>>)

    write(pid, <<0x06, 0xE7>>)
    write(pid, <<0x07, 0x7E>>)

    write(pid, <<0x08, 0xE7>>)
    write(pid, <<0x09, 0x7E>>)
    
    write(pid, <<0x0A, 0xFF>>)
    write(pid, <<0x0B, 0x7E>>)
    
    write(pid, <<0x0C, 0xFF>>)
    write(pid, <<0x0D, 0x7E>>)

    write(pid, <<0x0E, 0xFF>>)

    release(pid)
  end

  def draw_green_x() do
    pid = start()

    write(pid, <<0x01, 0xFF>>)
    
    write(pid, <<0x02, 0x7E>>)
    write(pid, <<0x03, 0xBD>>)

    write(pid, <<0x04, 0x7E>>)
    write(pid, <<0x05, 0xDB>>)

    write(pid, <<0x06, 0x7E>>)
    write(pid, <<0x07, 0xE7>>)

    write(pid, <<0x08, 0x7E>>)
    write(pid, <<0x09, 0xE7>>)
   
    write(pid, <<0x0A, 0x7E>>)
    write(pid, <<0x0B, 0xDB>>)
     
    write(pid, <<0x0C, 0x7E>>)
    write(pid, <<0x0D, 0xBD>>)

    write(pid, <<0x0F, 0xFF>>)

    release(pid)
  end

  def draw_red_dot() do
    pid = start()

    write(pid, <<0x01, 0x18>>)
    write(pid, <<0x03, 0x3C>>)
    write(pid, <<0x05, 0x7E>>)
    write(pid, <<0x07, 0xFF>>)
    write(pid, <<0x09, 0xFF>>)
    write(pid, <<0x0B, 0x7E>>)
    write(pid, <<0x0D, 0x3C>>)
    write(pid, <<0x0F, 0x18>>)

    release(pid)
  end

  def draw_green_dot() do
    pid = start()

    write(pid, <<0x00, 0x18>>)
    write(pid, <<0x02, 0x3C>>)
    write(pid, <<0x04, 0x7E>>)
    write(pid, <<0x06, 0xFF>>)
    write(pid, <<0x08, 0xFF>>)
    write(pid, <<0x0A, 0x7E>>)
    write(pid, <<0x0C, 0x3C>>)
    write(pid, <<0x0E, 0x18>>)

    release(pid)
  end

  def draw_yellow_dot() do
    draw_red_dot()
    draw_green_dot()
  end

  def draw_christmas_checkers() do
    pid = start()

    write(pid, <<0x00, 0xAA>>)
    write(pid, <<0x01, 0x55>>)
    
    write(pid, <<0x03, 0xAA>>)
    write(pid, <<0x02, 0x55>>)

    write(pid, <<0x04, 0xAA>>)
    write(pid, <<0x05, 0x55>>)

    write(pid, <<0x07, 0xAA>>)
    write(pid, <<0x06, 0x55>>)

    write(pid, <<0x08, 0xAA>>)
    write(pid, <<0x09, 0x55>>)

    write(pid, <<0x0B, 0xAA>>)
    write(pid, <<0x0A, 0x55>>)

    write(pid, <<0x0C, 0xAA>>)
    write(pid, <<0x0D, 0x55>>)

    write(pid, <<0x0F, 0xAA>>)
    write(pid, <<0x0E, 0x55>>)

    release(pid)
  end

  def draw_red_smiley() do
    pid = start()

    write(pid, <<0x01, 0x1C>>)
    write(pid, <<0x03, 0x42>>)
    write(pid, <<0x05, 0xA5>>)
    write(pid, <<0x07, 0x81>>)
    write(pid, <<0x09, 0xA5>>)
    write(pid, <<0x0B, 0x99>>)
    write(pid, <<0x0D, 0x42>>)
    write(pid, <<0x0F, 0x1C>>)

    release(pid)
  end

  def draw_green_smiley() do
    pid = start()

    write(pid, <<0x00, 0x1C>>)
    write(pid, <<0x02, 0x42>>)
    write(pid, <<0x04, 0xA5>>)
    write(pid, <<0x06, 0x81>>)
    write(pid, <<0x08, 0xA5>>)
    write(pid, <<0x0A, 0x99>>)
    write(pid, <<0x0C, 0x42>>)
    write(pid, <<0x0E, 0x1C>>)

    release(pid)
  end

  def draw_yellow_smiley() do
    draw_green_smiley()
    draw_red_smiley()
  end

  def draw_random() do
    index = :rand.uniform(tuple_size(drawings())) - 1
    clear()
    elem(drawings, index).()
  end

  defp drawings() do
    {
      &draw_target/0,
      &draw_green_x/0,
      &draw_green_dot/0,
      &draw_red_dot/0,
      &draw_yellow_dot/0,
      &draw_christmas_checkers/0,
      &draw_green_smiley/0,
      &draw_red_smiley/0,
      &draw_yellow_smiley/0
    }
  end
end
