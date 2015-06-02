module StatsInStone
  class Command
    def initialize(options)
      @options = options
    end

    attr_reader :options
    private     :options
  end
end
