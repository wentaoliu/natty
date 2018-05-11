class CreateWikis < ActiveRecord::Migration[5.0]
    def change
      create_table :wikis do |t|
        t.references  :user
        t.string      :title
        t.string      :category
        t.string      :content
        t.string      :comment
        t.boolean     :locked, default: false
  
        t.timestamps null: false
      end
    end
  end
  