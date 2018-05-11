class CreateActivities < ActiveRecord::Migration[5.0]
    def change
      create_table :activities do |t|
        t.integer   :owner
        t.string    :action
        t.integer   :subject_id
        t.string    :subject_type
        t.string    :summary

        t.timestamps null: false
      end
    end
  end
  