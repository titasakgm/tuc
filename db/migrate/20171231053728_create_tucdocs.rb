class CreateTucdocs < ActiveRecord::Migration[5.1]
  def change
    create_table :tucdocs do |t|
      t.string :coagyear
      t.string :project_id
      t.string :object_class_id
      t.string :item_no
      t.string :amend_no

      t.timestamps
    end
  end
end
