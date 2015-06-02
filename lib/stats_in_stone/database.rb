require "pstore"

require_relative "matchup_table"

module StatsInStone
  class Database
    READ_ONLY = true

    def initialize(path = "/Users/jeg2/.stats_in_stone_db.pstore")
      @path = path
    end

    attr_reader :path
    private     :path

    def clear
      File.unlink(path)
    end

    def record_game(game)
      date     = Time.now.strftime("%Y-%m-%d")
      category = game.won? ? :win : :loss
      db.transaction do
        db[:games]       ||= { }
        db[:games][date] ||= MatchupTable.new
        db[:games][date].send("record_#{category}", game.player, game.opponent)
      end
    end

    def all_games
      db.transaction(READ_ONLY) do
        db[:games]
      end
    end

    private

    def db
      @db ||= PStore.new(path)
    end
  end
end
