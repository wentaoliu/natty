class CreateBookings < ActiveRecord::Migration[5.0]
    def change
      create_table :bookings do |t|
        t.references  :user
        t.references  :instrument
        t.datetime    :starts_at
        t.datetime    :ends_at
        t.string      :record
  
        t.timestamps null: false
      end
    end
  end
  