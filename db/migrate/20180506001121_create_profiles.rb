class CreateProfiles < ActiveRecord::Migration[5.0]
    def change
      create_table :profiles do |t|
        t.references  :user
        t.attachment  :photo
        t.string      :email_public
        t.integer     :position, default: 0
        t.integer     :grade
        t.integer     :rank,  default: 0
        t.string      :resume
  
        t.timestamps null: false
      end
    end
  end
  