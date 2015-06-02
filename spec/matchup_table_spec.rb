require_relative "../lib/stats_in_stone/matchup_table"

describe StatsInStone::MatchupTable do
  let(:matchup_table) { StatsInStone::MatchupTable.new }

  it "starts with an empty ratio for any matchup" do
    ratio = matchup_table.matchup("Someone", "Someone Else")
    expect(ratio.wins).to  eq(0)
    expect(ratio.games).to eq(0)
  end

  it "tracks matchups separately" do
    matchup_table.record_win("Average", "Joe")
    matchup_table.record_win("Average", "Joe")
    matchup_table.record_loss("Average", "Joe")
    matchup_table.record_loss("Average", "Joe")
    10.times do
      matchup_table.record_loss("Total", "Loser")
    end
    average = matchup_table.matchup("Average", "Joe")
    expect(average.wins).to  eq(2)
    expect(average.games).to eq(4)
    loser = matchup_table.matchup("Total", "Loser")
    expect(loser.wins).to  eq(0)
    expect(loser.games).to eq(10)
  end

  it "adds matchups" do
    yesterday = StatsInStone::MatchupTable.new
    today     = StatsInStone::MatchupTable.new
    yesterday.record_win("A", "A")
    today.record_loss("A", "B")
    yesterday.record_win("B", "A")
    today.record_loss("B", "A")
    combined      = yesterday + today
    all_yesterday = combined.matchup("A", "A")
    expect(all_yesterday.wins).to  eq(1)
    expect(all_yesterday.games).to eq(1)
    all_today = combined.matchup("A", "B")
    expect(all_today.wins).to  eq(0)
    expect(all_today.games).to eq(1)
    both_days = combined.matchup("B", "A")
    expect(both_days.wins).to  eq(1)
    expect(both_days.games).to eq(2)
  end

  it "stringifies to a win ratio table" do
    matchup_table.record_win("Winner", "Winner")
    matchup_table.record_win("Winner", "Winner")
    matchup_table.record_win("Winner", "Loser")
    matchup_table.record_loss("Loser", "Winner")
    matchup_table.record_loss("Loser", "Winner")
    matchup_table.record_loss("Loser", "Loser")
    aliases = {"Winner" => "Winner", "Loser" => "Loser"}
    expect(matchup_table.to_s(aliases)).to eq(<<-END_TABLE.gsub(/^ {4}/, ""))
            Winner    Loser 

    Winner    2/2      1/1  
             100%     100%  

    Loser     0/2      0/1  
              0%       0%   
    END_TABLE
  end

  it "allows for aliases in tables" do
    matchup_table.record_win("Winner", "Winner")
    aliases = {"Winner" => "Win"}
    expect(matchup_table.to_s(aliases)).to eq(<<-END_TABLE.gsub(/^ {4}/, ""))
           Win  

    Win    1/1  
          100%  
    END_TABLE
  end
end
