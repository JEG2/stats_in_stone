require_relative "game"
require_relative "transitions"

module StatsInStone
  class Parser
    CARD_TRANSITION =
      "[Zone] ZoneChangeList.ProcessChanges() - TRANSITIONING card"
    WIN_LOSS        =
      / \A\[Asset\]\s+CachedAsset\.UnloadAssetObject\(\)\s+-\s+
        unloading\s+name=(victory|defeat)_screen_start\b /x

    def initialize(io)
      @io = io
    end

    attr_reader :io
    private     :io

    def parse
      game = Game.new
      io.each do |line|
        if line.start_with?(CARD_TRANSITION)
          transition = Transition.new(line)
          if transition.hero?
            game.send("#{transition.who}=", transition.name)
          end
        elsif line =~ WIN_LOSS
          game.won = $1 == "victory"
          yield game
          game = Game.new
        end
      end
    end
  end
end
