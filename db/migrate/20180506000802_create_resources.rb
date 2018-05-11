class CreateResources < ActiveRecord::Migration[5.0]
    def change
      create_table :resources do |t|
        t.references  :user
        t.string      :title
        t.integer     :parent
        t.integer     :ancestors, array: true, default: []
        t.boolean     :is_folder
        t.attachment  :document
  
        t.timestamps null: false
      end
    end
  end
  