class CreateProteins < ActiveRecord::Migration
  def change
    create_table :proteins do |t|
      t.integer :id
      t.text :sequence

      t.timestamps
    end
  end
end
