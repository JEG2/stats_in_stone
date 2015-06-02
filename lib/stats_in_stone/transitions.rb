module StatsInStone
  class Transition
    def initialize(line)
      @line = line
    end

    attr_reader :line
    private     :line

    def hero?
      line =~ /\(Hero\)\s*\z/
    end

    def who
      line[/to (FRIENDLY|OPPOSING) PLAY/, 1] == "FRIENDLY" ? :player : :opponent
    end

    def name
      line[/name=(.+?)(?=\]|\s+\w+=)/, 1]
    end
  end
end
