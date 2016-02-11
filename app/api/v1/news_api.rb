module V1
  class NewsAPI < Grape::API

    resource :news do
      authorize_routes!

      before do
        doorkeeper_authorize!
      end

      desc 'Get a list of news'
      params do
        optional :search, type: String
        optional :order, type: String, default: 'desc',
                         values: %w(desc asc)
        optional :page, type: Integer, default: 1
        optional :per, type: Integer, default: 10, values: 1..50
      end
      get '', authorize: [:read, News] do
        @news = can?(:create, News) ? News : News.where(hidden: false)
        if params[:search].present?
          @news = @news.where(title: /.*#{params[:search]}.*/i)
        end
        @news = @news.order(updated_at: params[:order])
                     .page(params[:page])
                     .per(params[:per])
        present @news
      end

      desc 'Create a news article'
      params do
        requires :title, type: String, desc: 'Title'
        requires :content, type: String, desc: 'Content'
        requires :hidden, type: Boolean, desc: 'Hidden?'
      end
      post '', authorize: [:create, News] do
        @news = News.new(title: params[:title], content: params[:content],
                         hidden: params[:hidden])
        @news.user = current_user
        if @news.save
          present @news
        else
          error!({ error: @news.errors.full_messages }, 400)
        end
      end

      namespace ':id' do

        desc 'Get a news article'
        get '', authorize: [:read, News] do
          @news = News.find(params[:id])
          @news.inc(hits: 1)
          present @news
        end

        desc 'Update a news article'
        params do
          requires :title, type: String, desc: 'Title'
          requires :content, type: String, desc: 'Content'
          requires :hidden, type: Boolean, desc: 'Hidden?'
        end
        put '', authorize: [:update, News] do
          @news = News.find(params[:id])
          if @news.update(title: params[:title], content: params[:content],
                          hidden: params[:hidden])
            present @news
          else
            error!({ error: @news.errors.full_messages }, 400)
          end
        end

        desc 'delete a news article'
        delete '', authorize: [:manage, News] do
          @news = News.find(params[:id])
          @news.destroy
          { ok: 1 }
        end

      end

    end

  end
end
