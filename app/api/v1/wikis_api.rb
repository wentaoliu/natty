module V1
  class WikisAPI < Grape::API

    resource :wikis do
      # authorize_routes!

      # before do
      #   token_authorize!
      # end

      desc 'Get a list of wiki articles'
      params do
        optional :search, type: String
        optional :order, type: String, default: 'desc',
                         values: %w(desc asc)
        optional :page, type: Integer, default: 1
        optional :per, type: Integer, default: 10, values: 1..50
      end
      get '', authorize: [:read, Wiki] do
        @wikis = can?(:create, Wiki) ? Wiki : Wiki.where(hidden: false)
        if params[:search].present?
          @wikis = @wikis.where(title: /.*#{params[:search]}.*/i)
        end
        @wikis = @wikis.order(updated_at: params[:order])
                             .page(params[:page])
                             .per(params[:per])
        present @wikis
      end

      desc 'Create a new wiki article'
      params do
        requires :title, type: String, desc: 'Title'
        requires :content, type: String, desc: 'Content'
        requires :comment, type: String, desc: 'Comment'
        requires :hidden, type: Boolean, desc: 'Hidden?'
      end
      post '', authorize: [:create, Wiki] do
        @wiki = Wiki.new(title: params[:title], content: params[:content],
                        comment: params[:comment], hidden: params[:hidden])
        @wiki.user = current_user
        if @wiki.save
          present @wiki
        else
          error!({ error: @wiki.errors.full_messages }, 400)
        end
      end

      namespace ':id' do

        desc 'Get a wiki article'
        get '', authorize: [:read, Wiki] do
          @wiki = Wiki.find(params[:id])
          present @wiki
        end

        desc 'Update a wiki article'
        params do
          requires :title, type: String, desc: 'Title'
          requires :content, type: String, desc: 'Content'
          requires :comment, type: String, desc: 'Comment'
          requires :hidden, type: Boolean, desc: 'Hidden?'
        end
        put '', authorize: [:update, Wiki] do
          @wiki = Wiki.find(params[:id])
          if @wiki.update(title: params[:title], content: params[:content],
                          comment: params[:comment], hidden: params[:hidden])
            present @wiki
          else
            error!({ error: @wiki.errors.full_messages }, 400)
          end
        end

        desc 'delete a wiki article'
        delete '', authorize: [:manage, Wiki] do
          @wiki = Wiki.find(params[:id])
          @wiki.destroy
          { ok: 1 }
        end

      end

    end

  end
end
