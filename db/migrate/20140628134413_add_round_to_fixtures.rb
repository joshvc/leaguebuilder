class AddRoundToFixtures < ActiveRecord::Migration
  def change
    add_column :fixtures, :round, :integer
  end
end
