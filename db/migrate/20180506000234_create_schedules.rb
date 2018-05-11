class CreateSchedules < ActiveRecord::Migration[5.0]
    def change
      create_table :schedules do |t|
        t.references  :user
        t.string      :title
        t.datetime    :starts_at
        t.datetime    :ends_at
        t.string      :category
        t.string      :place
        t.string      :content
        t.boolean     :bulletin, default: false
        t.boolean     :private, default: false
  
        t.timestamps null: false
      end
    end
  end
  