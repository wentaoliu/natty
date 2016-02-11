module V1
  class OrdersAPI < Grape::API

    resource :orders do
      authorize_routes!

      before do
        doorkeeper_authorize!
      end

      desc 'Get a list of orders'
      params do
        optional :search, type: String
        optional :order, type: String, default: 'desc',
                         values: %w(desc asc)
        optional :page, type: Integer, default: 1
        optional :per, type: Integer, default: 10, values: 1..50
      end
      get '', authorize: [:read, Order] do
        @orders = can?(:create, Order) ? Order : Order.where(hidden: false)
        if params[:search].present?
          @orders = @orders.where(title: /.*#{params[:search]}.*/i)
        end
        @orders = @orders.order(updated_at: params[:order])
                             .page(params[:page])
                             .per(params[:per])
        present @orders
      end

      desc 'Create a new order'
      params do
        requires :title, type: String, desc: 'Title'
        requires :quantity, type: Integer, default: 0, desc: 'Quantity'
        requires :unit_size, type: String, desc: 'Unit size'
        requires :unit_price, type: Float, desc: 'Unit price'
        requires :total_price, type: Float, desc: 'Total price'
        requires :bought_from, type: String, desc: 'Bought from'
        requires :type, type: String, desc: 'Type'
        requires :vendor_name, type: String, desc: 'Vendor name'
        requires :invoice, type: String, desc: 'Invoice number'
        requires :notes, type: String, desc: 'Notes'
        requires :hidden, type: Boolean, desc: 'Hidden?'
      end
      post '', authorize: [:create, Order] do
        @order = Order.new(title: params[:title], quantity: params[:quantity],
                  unit_size: params[:unit_size], unit_price: params[:unit_price],
                  total_price: params[:total_price],
                  bought_from: params[:bought_from],
                  type: params[:type],
                  vendor_name: params[:vendor_name],
                  invoice: params[:invoice], notes: params[:notes],
                  hidden: params[:hidden])
        @order.user = current_user
        if @order.save
          present @order
        else
          error!({ error: @order.errors.full_messages }, 400)
        end
      end

      namespace ':id' do

        desc 'Get an order'
        get '', authorize: [:read, Order] do
          @order = Order.find(params[:id])
          present @order
        end

        desc 'Update an order'
        params do
          requires :title, type: String, desc: 'Title'
          requires :quantity, type: Integer, default: 0, desc: 'Quantity'
          requires :unit_size, type: String, desc: 'Unit size'
          requires :unit_price, type: Float, desc: 'Unit price'
          requires :total_price, type: Float, desc: 'Total price'
          requires :bought_from, type: String, desc: 'Bought from'
          requires :type, type: String, desc: 'Type'
          requires :vendor_name, type: String, desc: 'Vendor name'
          requires :invoice, type: String, desc: 'Invoice number'
          requires :notes, type: String, desc: 'Notes'
          requires :hidden, type: Boolean, desc: 'Hidden?'
        end
        put '', authorize: [:update, News] do
          @order = Order.find(params[:id])
          if @order.update(title: params[:title], quantity: params[:quantity],
                    unit_size: params[:unit_size], unit_price: params[:unit_price],
                    total_price: params[:total_price],
                    bought_from: params[:bought_from],
                    type: params[:type],
                    vendor_name: params[:vendor_name],
                    invoice: params[:invoice], notes: params[:notes],
                    hidden: params[:hidden])
            present @order
          else
            error!({ error: @order.errors.full_messages }, 400)
          end
        end

        desc 'delete an order'
        delete '', authorize: [:manage, Order] do
          @order = Order.find(params[:id])
          @order.destroy
          { ok: 1 }
        end

      end

    end

  end
end
