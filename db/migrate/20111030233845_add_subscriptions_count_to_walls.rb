class AddSubscriptionsCountToWalls < ActiveRecord::Migration
  def change
    add_column :walls, :subscriptions_count, :integer
  end
end
