class CreateDevotionEntries < ActiveRecord::Migration
  def change
    create_table :devotion_entries do |t|
      t.string :content
      t.string :user_id

      t.timestamps null: false
    end
  end
end
