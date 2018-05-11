class CreateComments < ActiveRecord::Migration[5.0]
    def change
      create_table :comments do |t|
        t.references  :topic
        t.references  :user
        t.integer     :reply_to
        t.string      :content
        t.boolean     :proved, default: false
        t.boolean     :hidden, default: false
  
        t.timestamps null: false
      end
    end
  end
  