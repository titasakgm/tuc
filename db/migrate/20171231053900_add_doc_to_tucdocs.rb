class AddDocToTucdocs < ActiveRecord::Migration[5.1]
  def change
    add_column :tucdocs, :doc, :string
  end
end
