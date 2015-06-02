require_relative "command"
require_relative "database"
require_relative "parser"

module StatsInStone
  class LoadCommand < Command
    LOG_FILE = "/Users/jeg2/Library/Logs/Unity/Player.log"

    def run
      db = Database.new
      open(LOG_FILE, "r") do |io|
        Parser.new(io).parse do |finished_game|
          db.record_game(finished_game)
        end
      end
    end
  end
end
