class AddViewsToWall < ActiveRecord::Migration
  def change
    add_column :walls, :views, :integer
  end
end
