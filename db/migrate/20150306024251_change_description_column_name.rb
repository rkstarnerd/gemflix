class ChangeDescriptionColumnName < ActiveRecord::Migration
  def change
    rename_column :videos, :desription, :description
  end
end
