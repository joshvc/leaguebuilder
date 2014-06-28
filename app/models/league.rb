class League < ActiveRecord::Base
  has_many :teams
  has_many :fixtures
  validates :name, presence: true

  accepts_nested_attributes_for :teams

  before_create :set_shortcode

  def build_fixtures
    add_bye_team if teams.count.odd?
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

  def rounds
    teams.count - 1
  end

  def to_param
    shortcode
  end

  def self.lookup(query)
    if query.to_i == 0
      result = self.find_by_shortcode(query)
    else
      result = self.find(query)
    end
    if result.nil?
      raise ActiveRecord::RecordNotFound
    else
      return result
    end
  end

  private

  def set_shortcode
    begin
      self.shortcode = SecureRandom.urlsafe_base64(5)
    end while League.exists?(shortcode: self.shortcode)
  end

  def add_bye_team
    teams.create(name: "Bye")
  end
end
