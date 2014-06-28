require 'test_helper'

describe League do
  def setup_league
    @league = League.create(name:'league')
  end
  def setup_3_teams
    setup_league
    @team1 = @league.teams.create(name:"team1")
    @team2 = @league.teams.create(name:"team2")
    @team3 = @league.teams.create(name:"team3")
  end
  def setup_4_teams
    setup_3_teams
    @team4 = @league.teams.create(name:"team4")
  end

  it "is invalid without a name" do
    league = League.create()

    refute league.valid?, "can't be valid without a name"
  end

  describe '#rounds' do
    it 'returns the correct number of rounds' do
      setup_4_teams
      @league.rounds.must_equal 3
    end
  end


  describe '#build_fixtures' do
    describe 'with even number of teams' do
      before do
        setup_4_teams
        @league.build_fixtures
      end

      it 'creates the correct number of fixtures' do
        @league.fixtures.count.must_equal ((@league.teams.count - 1) * (@league.teams.count / 2))
      end

      it 'matches each team against all others one time' do
        @team1.fixtures.where('away_team_id = ? OR home_team_id = ?', @team2.id, @team2.id).count.must_equal 1
      end

      it 'assigns the right rounds' do
        @league.fixtures.map{|f| f.round}.must_equal [1, 1, 2, 2, 3, 3]
      end
    end

    describe 'with odd number of teams' do
      before do
        setup_3_teams
        @league.build_fixtures
      end

      it 'adds an extra team' do
        @league.teams.count.must_equal 4
      end

      it 'adds a team called Bye' do
        @league.teams.last.name.must_equal 'Bye'
      end
    end
  end

  describe '.lookup' do
    before do
      setup_league
    end

    it 'finds the league by shortcode' do
      League.lookup(@league.shortcode).must_equal @league
    end

    it 'finds the league by id' do
      League.lookup(@league.id).must_equal @league
    end

    it 'raises RecordNotFound if not found' do
      assert_raises(ActiveRecord::RecordNotFound) { League.lookup('sandwich') }
    end
  end
end
