require 'test_helper'

describe Team do
  it "is invalid without a name" do
    team = Team.create()
    refute team.valid?, "can't be valid without a name"
  end
end
