class CreateVersions < ActiveRecord::Migration[5.0]
    def change
      create_table :versions do |t|
        t.references  :user
        t.references  :wiki
        t.string      :title
        t.string      :category
        t.string      :content
        t.string      :comment
        t.boolean     :current, default: false
  
        t.timestamps null: false
      end
    end
  end
  