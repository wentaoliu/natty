class CreateInventories < ActiveRecord::Migration[5.0]
    def change
      create_table :inventories do |t|
        t.references  :user
        t.string      :item_name
        t.float       :price
        t.integer     :quantity
        t.string      :unit_size
        t.string      :url
        t.string      :technical_details
        t.datetime    :expiration_date
        t.string      :cas_number
        t.string      :serial_number
        t.string      :bought_from
        t.string      :location
        t.string      :sub_location
        t.string      :location_details
        t.string      :type
        t.string      :vendor_name
  
        t.timestamps null: false
      end
    end
  end
  