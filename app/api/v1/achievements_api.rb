module V1
  class AchievementsAPI < Grape::API

    resource :achievements do
      authorize_routes!

      before do
        doorkeeper_authorize!
      end

      desc 'Get a list of achievements'
      params do
        optional :search, type: String
        optional :order, type: String, default: 'desc',
                         values: %w(desc asc)
        optional :page, type: Integer, default: 1
        optional :per, type: Integer, default: 10, values: 1..50
      end
      get '', authorize: [:read, Achievement] do
        @achievements = can?(:create, Achievement) ? Achievement : Achievement.where(hidden: false)
        if params[:search].present?
          @achievements = @achievements.where(title: /.*#{params[:search]}.*/i)
        end
        @achievements = @achievements.order(updated_at: params[:order])
                         .page(params[:page])
                         .per(params[:per])
        present @achievements
      end

      desc 'Create a new achievement'
      params do
        requires :title, type: String, desc: 'Title'
        requires :content, type: String, desc: 'Content'
        requires :author, type: String, desc: 'Author'
        requires :link, type: String, desc: 'Link'
        requires :date, type: Date, desc: 'Date'
        requires :type, type: Integer, desc: 'Type'
        requires :hidden, type: Boolean, desc: 'Hidden?'
      end
      post '', authorize: [:create, Achievement] do
        @achievement = Achievement.new(title: params[:title], content: params[:content],
                        author: params[:author], link: params[:link],
                        date: params[:date], type: params[:type],
                        hidden: params[:hidden])
        @achievement.user = current_user
        if @achievement.save
          present @achievement
        else
          error!({ error: @achievement.errors.full_messages }, 400)
        end
      end

      namespace ':id' do

        desc 'Get an achievement'
        get '', authorize: [:read, Achievement] do
          @achievement = Achievement.find(params[:id])
          present @achievement
        end

        desc 'Update an achievement'
        params do
          requires :title, type: String, desc: 'Title'
          requires :content, type: String, desc: 'Content'
          requires :author, type: String, desc: 'Author'
          requires :link, type: String, desc: 'Link'
          requires :date, type: Date, desc: 'Date'
          requires :type, type: Integer, desc: 'Type'
          requires :hidden, type: Boolean, desc: 'Hidden?'
        end
        put '', authorize: [:update, News] do
          @meeting = Meeting.find(params[:id])
          if @meeting.update(title: params[:title], content: params[:content],
                          author: params[:author], link: params[:link],
                          date: params[:date], type: params[:type],
                          hidden: params[:hidden])
            present @meeting
          else
            error!({ error: @meeting.errors.full_messages }, 400)
          end
        end

        desc 'delete an achievement'
        delete '', authorize: [:manage, Achievement] do
          @achievement = Achievement.find(params[:id])
          @achievement.destroy
          { ok: 1 }
        end

      end

    end

  end
end
