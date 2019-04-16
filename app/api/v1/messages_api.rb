module V1
  class MessagesAPI < Grape::API

    resource :messages do

      # before do
      #   token_authorize!
      # end

      desc 'Get a list of messages'
      params do
        optional :page, type: Integer, default: 1
        optional :per, type: Integer, default: 10, values: 1..50
      end
      get '' do
        present Message.order(created_at: :desc).page(params[:page]).per(params[:per])
      end

      desc 'Create a new message'
      params do
        requires :content, type: String, desc: 'Content'
      end
      post '' do
        @message = Message.new(content: params[:content])
        @message.user = current_user
        if @message.save
          present @message
        else
          error!({ error: @message.errors.full_messages }, 400)
        end
      end

      namespace ':id' do

        desc 'delete a message'
        delete '' do
          @message = Topic.find(params[:id])
          @message.destroy
          { ok: 1 }
        end

      end

    end

  end
end
