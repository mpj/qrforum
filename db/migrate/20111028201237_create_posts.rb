class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :body
      t.string :signature
      t.integer :wall_id

      t.timestamps
    end
  end
end
