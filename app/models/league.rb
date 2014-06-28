class League < ActiveRecord::Base
  has_many :teams
  has_many :fixtures
  validates :name, presence: true

  def build_fixtures
    team_array = teams.map{|t| t.id}
    (self.teams.count - 1).times do |i|
      round_array = team_array.clone

      while round_array != [] do
        self.fixtures.create!(home_team_id: round_array.first, away_team_id: round_array.last, round: i+1)
        round_array.shift
        round_array.pop
      end

      team_array.insert(1, team_array.last)
      team_array.pop

    end
  end
end
