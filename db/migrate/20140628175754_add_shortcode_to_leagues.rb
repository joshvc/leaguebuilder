class AddShortcodeToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :shortcode, :string
  end
end
