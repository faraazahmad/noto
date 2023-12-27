class CellRenameTypeColumn < ActiveRecord::Migration[7.1]
  def change
    rename_column :cells, :type, :cell_type
  end
end
