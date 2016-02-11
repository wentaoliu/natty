module V1
  class InventoriesAPI < Grape::API

    resource :inventories do
      authorize_routes!

      before do
        doorkeeper_authorize!
      end

      desc 'Get a list of inventories'
      params do
        optional :search, type: String
        optional :order, type: String, default: 'desc',
                         values: %w(desc asc)
        optional :page, type: Integer, default: 1
        optional :per, type: Integer, default: 10, values: 1..50
      end
      get '', authorize: [:read, Inventory] do
        @inventories = can?(:create, Inventory) ? Inventory : Inventory.where(hidden: false)
        if params[:search].present?
          @inventories = @inventories.where(title: /.*#{params[:search]}.*/i)
        end
        @inventories = @inventories.order(updated_at: params[:order])
                             .page(params[:page])
                             .per(params[:per])
        present @inventories
      end

      desc 'Create a new inventory'
      params do
        requires :item_name, type: String, desc: 'Item name'
        requires :price, type: Float, default: 0, desc: 'Price'
        requires :quantity, type: Integer, default: 0, desc: 'Quantity'
        requires :unit_size, type: String, desc: 'Unit size'
        requires :url, type: String, desc: 'Url'
        requires :technical_details, type: String, desc: 'Technical details'
        requires :expiration_date, type: Date, desc: 'Expiration date'
        requires :cas_number, type: String, desc: 'CAS number'
        requires :serial_number, type: String, desc: 'Serial number'
        requires :bought_from, type: String, desc: 'Bought from'
        requires :location, type: String, desc: 'Location'
        requires :sub_location, type: String, desc: 'Sub location'
        requires :location_details, type: String, desc: 'Location details'
        requires :type, type: String, desc: 'Type'
        requires :vendor_name, type: String, desc: 'Vendor name'
        requires :hidden, type: Boolean, desc: 'Hidden?'
      end
      post '', authorize: [:create, Inventory] do
        @inventory = Inventory.new(item_name: params[:item_name], price: params[:price],
                      quantity: params[:quantity], unit_size: params[:unit_size],
                      url: params[:url], technical_details: params[:technical_details],
                      expiration_date: params[:expiration_date],
                      cas_number: params[:cas_number],
                      serial_number: params[:serial_number],
                      bought_from: params[:bought_from], location: params[:location],
                      sub_location: params[:sub_location],
                      location_details: params[:location_details],
                      type: params[:type], vendor_name: params[:vendor_name],
                      hidden: params[:hidden])
        @inventory.user = current_user
        if @inventory.save
          present @inventory
        else
          error!({ error: @inventory.errors.full_messages }, 400)
        end
      end

      namespace ':id' do

        desc 'Get an inventory'
        get '', authorize: [:read, Inventory] do
          @inventory = Inventory.find(params[:id])
          present @inventory
        end

        desc 'Update an inventory'
        params do
          requires :item_name, type: String, desc: 'Item name'
          requires :price, type: Float, default: 0, desc: 'Price'
          requires :quantity, type: Integer, default: 0, desc: 'Quantity'
          requires :unit_size, type: String, desc: 'Unit size'
          requires :url, type: String, desc: 'Url'
          requires :technical_details, type: String, desc: 'Technical details'
          requires :expiration_date, type: Date, desc: 'Expiration date'
          requires :cas_number, type: String, desc: 'CAS number'
          requires :serial_number, type: String, desc: 'Serial number'
          requires :bought_from, type: String, desc: 'Bought from'
          requires :location, type: String, desc: 'Location'
          requires :sub_location, type: String, desc: 'Sub location'
          requires :location_details, type: String, desc: 'Location details'
          requires :type, type: String, desc: 'Type'
          requires :vendor_name, type: String, desc: 'Vendor name'
          requires :hidden, type: Boolean, desc: 'Hidden?'
        end
        put '', authorize: [:update, News] do
          @inventory = Inventory.find(params[:id])
          if @inventory.update(item_name: params[:item_name], price: params[:price],
                        quantity: params[:quantity], unit_size: params[:unit_size],
                        url: params[:url], technical_details: params[:technical_details],
                        expiration_date: params[:expiration_date],
                        cas_number: params[:cas_number],
                        serial_number: params[:serial_number],
                        bought_from: params[:bought_from], location: params[:location],
                        sub_location: params[:sub_location],
                        location_details: params[:location_details],
                        type: params[:type], vendor_name: params[:vendor_name],
                        hidden: params[:hidden])
            present @inventory
          else
            error!({ error: @inventory.errors.full_messages }, 400)
          end
        end

        desc 'delete an inventory'
        delete '', authorize: [:manage, Inventory] do
          @inventory = Inventory.find(params[:id])
          @inventory.destroy
          { ok: 1 }
        end

      end

    end

  end
end
