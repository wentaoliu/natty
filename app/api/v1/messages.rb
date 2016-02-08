module V1
  class Messages < Grape::API

    resource :messages do

      params do
        optional :page, type: Integer, default: 1
        optional :per, type: Integer, default: 10, values: 1..50
      end
      get '' do
        present Message.order(created_at: :desc).page(params[:page]).per(params[:per])
      end

    end

  end
end
