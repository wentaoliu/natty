class CreateTopics < ActiveRecord::Migration[5.0]
    def change
      create_table :topics do |t|
        t.references  :user
        t.references  :forum
        t.string      :title
        t.string      :content
        t.string      :tags, array: true, default: []
        t.integer     :comments_count, default: 0
        t.integer     :hits, default: 0
        t.boolean     :hidden, default: false
        t.boolean     :allow_comments, default: true
  
        t.timestamps null: false
      end
    end
  end
  