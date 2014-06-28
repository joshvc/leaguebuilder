require 'test_helper'

describe League do
  it "is invalid without a name" do
    league = League.create()

    refute league.valid?, "can't be valid without a name"
  end


end
