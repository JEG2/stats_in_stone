require_relative "../lib/stats_in_stone/win_ratio"

describe StatsInStone::WinRatio do
  let(:win_ratio) {
    StatsInStone::WinRatio.new.tap do |wr|
      wr.record_win
      wr.record_loss
      wr.record_win
    end
  }

  it "tracks a number of wins" do
    expect(win_ratio.wins).to eq(2)
  end

  it "tracks a number of games" do
    expect(win_ratio.games).to eq(3)
  end

  it "builds the ratio" do
    expect(win_ratio.ratio).to eq("2/3")
  end

  it "builds the percent" do
    expect(win_ratio.percent).to eq("67%")
  end

  it "adds counts" do
    double = win_ratio + win_ratio
    expect(double.wins).to  eq(win_ratio.wins * 2)
    expect(double.games).to eq(win_ratio.games * 2)
  end

  it "builds nothing for empty counts" do
    empty = StatsInStone::WinRatio.new
    expect(empty.ratio).to   eq("")
    expect(empty.percent).to eq("")
  end
end
