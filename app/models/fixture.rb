class Fixture < ActiveRecord::Base
  validates :home_team_id, presence: true
  validates :away_team_id, presence: true
end
