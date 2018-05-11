class CreateInstruments < ActiveRecord::Migration[5.0]
    def change
      create_table :instruments do |t|
        t.string    :name
        t.string    :location
        t.string    :serial_number
        t.string    :description
        t.integer   :maintainer
        t.boolean   :available, default: true
  
        t.timestamps null: false
      end
    end
  end
  