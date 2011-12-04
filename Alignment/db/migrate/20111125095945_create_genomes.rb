class CreateGenomes < ActiveRecord::Migration
  def change
    create_table :genomes do |t|
      t.string :name
      t.text :sequence

      t.timestamps
    end
  end
end
