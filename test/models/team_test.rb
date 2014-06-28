require 'test_helper'

describe Team do
  it "is invalid without a name" do
    team = Team.create()
    refute team.valid?, "can't be valid without a name"
  end

  describe '#fixtures' do
    before do
      @team = Team.create!(name:"team")
      @game1 = Fixture.create!(home_team_id: @team.id, away_team_id: 1000, round: 2)
      @game2 = Fixture.create!(away_team_id: @team.id, home_team_id: 1001, round: 1)
    end

    it 'should find all the fixtures' do
      @team.fixtures.count.must_equal 2
    end

    it 'should return all the fixtures' do
      assert @team.fixtures.include?(@game1), "Fixture missing from response"
      assert @team.fixtures.include?(@game2), "Fixture missing from response"
    end

    it 'should return them in order' do
      @team.fixtures.first.must_equal @game2
    end

  end
end
