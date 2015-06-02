module StatsInStone
  class Game
    def initialize
      @player   = nil
      @opponent = nil
      @won      = nil
    end

    attr_accessor :player, :opponent
    attr_writer   :won

    def won?
      @won
    end
  end
end
