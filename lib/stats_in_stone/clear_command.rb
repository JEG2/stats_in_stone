require_relative "command"
require_relative "database"

module StatsInStone
  class ClearCommand < Command
    def run
      Database.new.clear
    end
  end
end
