module V1
  class Messages < Grape::API

    resource :messages do
      authorize_routes!

      before do
        doorkeeper_authorize!
      end

      params do
        optional :page, type: Integer, default: 1
        optional :per, type: Integer, default: 10, values: 1..50
      end
      get '', authorize: [:read, Message] do
        present Message.order(created_at: :desc).page(params[:page]).per(params[:per])
      end

    end

  end
end
