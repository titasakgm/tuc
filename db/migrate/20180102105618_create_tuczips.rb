class CreateTuczips < ActiveRecord::Migration[5.1]
  def change
    create_table :tuczips do |t|
      t.string :filename
      t.string :mtime
    end
  end
end
