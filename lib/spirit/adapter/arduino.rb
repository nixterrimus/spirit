require 'dino'

class Adapter::Arduino
  def initialize
    board = Dino::Board.new(Dino::TxRx.new)
    @led = Dino::Components::Led.new(pin: 13, board: board)
  end

  def on(device)
    @led.send(:on)
  end

  def off(device)
    @led.send(:off)
  end
end
