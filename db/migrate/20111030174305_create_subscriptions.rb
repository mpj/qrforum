class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :email
      t.boolean :confirmed
      t.string :secret

      t.timestamps
    end
  end
end
