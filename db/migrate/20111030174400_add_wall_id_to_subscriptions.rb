class AddWallIdToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :wall_id, :integer
  end
end
