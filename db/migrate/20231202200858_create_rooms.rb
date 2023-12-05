class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :image
      t.string :address
      t.string :detail
      t.integer :charge

      t.timestamps
    end
  end
end
