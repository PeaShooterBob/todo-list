class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :action, :null => false
      t.references :project, index: true
      t.boolean :done, :default => false, :null => false

      t.timestamps
    end
  end
end
