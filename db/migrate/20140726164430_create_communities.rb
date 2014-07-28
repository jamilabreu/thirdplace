class CreateCommunities < ActiveRecord::Migration
  def change
    create_table :communities do |t|
      t.string :name
      t.integer :city_id
      t.string :type

      t.timestamps
    end
  end
end
