class CreateWalls < ActiveRecord::Migration
  def change
    create_table :walls do |t|
      t.string :title
      t.string :code

      t.timestamps
    end
  end
end
