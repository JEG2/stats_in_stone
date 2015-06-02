require_relative "command"
require_relative "database"

module StatsInStone
  class ReportCommand < Command
    def run
      db    = Database.new
      games = db.all_games

      puts games.keys.minmax.join(" to ")
      puts
      puts games.values.inject(:+)
    end
  end
end
