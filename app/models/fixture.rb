class Fixture < ActiveRecord::Base
  belongs_to :home_team, class: 'Team'
  belongs_to :away_team, class: 'Team'
  validates :home_team_id, presence: true
  validates :away_team_id, presence: true
end
