module StatsInStone
  class WinRatio
    def initialize(wins = 0, games = 0)
      @wins  = wins
      @games = games
    end

    attr_reader :wins, :games

    def record_win
      @wins  += 1
      @games += 1
    end

    def record_loss
      @games += 1
    end

    def ratio
      return "" if games.zero?

      "%d/%d" % [wins, games]
    end

    def percent
      return "" if games.zero?

      "%.0f%%" % [wins / games.to_f * 100]
    end

    def +(other)
      self.class.new(wins + other.wins, games + other.games)
    end
  end
end
