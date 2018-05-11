class CreateForums < ActiveRecord::Migration[5.0]
    def change
      create_table :forums do |t|
        t.string      :name
        t.string      :description
        t.boolean     :hidden
  
        t.timestamps null: false
      end
    end
  end
  