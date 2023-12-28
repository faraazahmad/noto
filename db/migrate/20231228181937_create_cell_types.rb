class CreateCellTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :cell_types do |t|
      t.string :label
      t.integer :value

      t.timestamps
    end
  end
end
