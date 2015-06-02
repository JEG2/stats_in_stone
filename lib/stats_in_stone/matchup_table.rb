require_relative "win_ratio"

module StatsInStone
  class MatchupTable
    HEROES = {
      "Malfurion Stormrage" => "Dru",
      "Rexxar"              => "Hun",
      "Jaina Proudmoore"    => "Mag",
      "Uther Lightbringer"  => "Pal",
      "Anduin Wrynn"        => "Pri",
      "Valeera Sanguinar"   => "Rog",
      "Thrall"              => "Sha",
      "Gul'dan"             => "Wlk",
      "Garrosh Hellscream"  => "War"
    }

    def initialize(matchups = { })
      @matchups = matchups
    end

    attr_reader :matchups
    protected   :matchups

    def matchup(player, opponent)
      matchups[[player, opponent]] ||= WinRatio.new
    end

    def record_win(*players)
      matchup(*players).record_win
    end

    def record_loss(*players)
      matchup(*players).record_loss
    end

    def +(other)
      self.class.new(matchups.merge(other.matchups) { |_, l, r| l + r })
    end

    def to_s(aliases = HEROES)
      first_column_width = aliases.values.map(&:size).max
      other_column_width = [first_column_width, 7].max
      format             = "%-#{first_column_width}s"                 +
                           "  %#{other_column_width}s" * aliases.size +
                           "\n"

      string  = format % [
        "",
        *aliases.values.map { |o| o.center(other_column_width) }
      ]
      string << "\n"
      aliases.each do |player, player_alias|
        string << format % [
          player_alias,
          *aliases.keys.map { |o|
            matchup(player, o).ratio.center(other_column_width)
          }
        ]
        string << format % [
          "",
          *aliases.keys.map { |o|
            matchup(player, o).percent.center(other_column_width)
          }
        ]
        string << "\n"
      end
      string.chomp
    end
  end
end
