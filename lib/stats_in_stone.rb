require_relative "stats_in_stone/clear_command"
require_relative "stats_in_stone/load_command"
require_relative "stats_in_stone/report_command"

module StatsInStone
  module_function

  def run(args)
    selected = args.first.downcase
    command  =
      if    "clear".start_with?(selected)  then ClearCommand
      elsif "load".start_with?(selected)   then LoadCommand
      elsif "report".start_with?(selected) then ReportCommand
      else  abort("Unknown command:  #{args.first}")
      end
    command.new(args[1..-1]).run
  end
end
