require 'test_helper'

describe League do
  it "is invalid without a name" do
    league = League.create()

    refute league.valid?, "can't be valid without a name"
  end

  describe '#build_fixtures' do
    describe 'with even number of teams' do
      before do
        @league = League.create(name:'league')
        @team1 = @league.teams.create(name:"team1")
        @team2 = @league.teams.create(name:"team2")
        @team3 = @league.teams.create(name:"team3")
        @team4 = @league.teams.create(name:"team4")
        @league.build_fixtures
      end

      it 'creates the correct number of fixtures' do
        @league.fixtures.count.must_equal ((@league.teams.count - 1) * (@league.teams.count / 2))
      end

      it 'matches each team against all others one time' do
        @team1.fixtures.where('away_team_id = ? OR home_team_id = ?', @team2.id, @team2.id).count.must_equal 1
      end

      it 'should assign the right rounds' do
        @league.fixtures.map{|f| f.round}.must_equal [1, 1, 2, 2, 3, 3]
      end
    end
  end
end
