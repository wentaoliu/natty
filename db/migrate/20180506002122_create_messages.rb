class CreateMessages < ActiveRecord::Migration[5.0]
    def change
      create_table :messages do |t|
        t.references  :user
        t.string      :content
        t.integer     :like, array: true, default: []
  
        t.timestamps null: false
      end
    end
  end
  