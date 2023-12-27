class CreateCells < ActiveRecord::Migration[7.1]
  def change
    create_table :cells do |t|
      t.integer :type
      t.text :content
      t.text :output
      t.references :notebook, null: false, foreign_key: true

      t.timestamps
    end
  end
end
