require 'test_helper'

describe Fixture do
  def valid_params
    {home_team_id: 1, away_team_id: 2}
  end

  it "is valid with two teams" do
    fixture = Fixture.new(valid_params)
    assert fixture.valid?, "not valid with two team ids"
  end

  it "is invalid without a home team" do
    fixture = Fixture.new(away_team_id: 1)
    refute fixture.valid?, "can't be valid without a home team"
  end

  it "is invalid without a home team" do
    fixture = Fixture.new(home_team_id: 1)
    refute fixture.valid?, "can't be valid without an away team"
  end
end
