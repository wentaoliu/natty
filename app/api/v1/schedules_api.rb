module V1
  class SchedulesAPI < Grape::API

    resource :schedules do
      authorize_routes!

      before do
        token_authorize!
      end

      desc 'Get a list of schedules'
      params do
        optional :search, type: String
        optional :order, type: String, default: 'desc',
                         values: %w(desc asc)
        optional :page, type: Integer, default: 1
        optional :per, type: Integer, default: 10, values: 1..50
      end
      get '', authorize: [:read, Schedule] do
        @schedules = can?(:create, Schedule) ? Schedule : Schedule.where(hidden: false)
        if params[:search].present?
          @schedules = @schedules.where(title: /.*#{params[:search]}.*/i)
        end
        @schedules = @schedules.order(updated_at: params[:order])
                             .page(params[:page])
                             .per(params[:per])
        present @schedules
      end

      desc 'Create a new schedule'
      params do
        requires :title, type: String, desc: 'Title'
        requires :content, type: String, desc: 'Content'
        requires :starts_at, type: DateTime, desc: 'Starts at'
        requires :ends_at, type: DateTime, desc: 'Ends at'
        requires :place, type: String, desc: 'Place'
        requires :hidden, type: Boolean, desc: 'Hidden?'
      end
      post '', authorize: [:create, Schedule] do
        @schedule = Schedule.new(title: params[:title], content: params[:content],
                           starts_at: params[:starts_at], ends_at: params[:ends_at],
                           place: params[:place], hidden: params[:hidden])
        @schedule.user = current_user
        if @schedule.save
          present @schedule
        else
          error!({ error: @schedule.errors.full_messages }, 400)
        end
      end

      namespace ':id' do

        desc 'Get a schedule'
        get '', authorize: [:read, Schedule] do
          @schedule = Schedule.find(params[:id])
          present @schedule
        end

        desc 'Update a schedule'
        params do
          requires :title, type: String, desc: 'Title'
          requires :content, type: String, desc: 'Content'
          requires :starts_at, type: DateTime, desc: 'Starts at'
          requires :ends_at, type: DateTime, desc: 'Ends at'
          requires :place, type: String, desc: 'Place'
          requires :hidden, type: Boolean, desc: 'Hidden?'
        end
        put '', authorize: [:update, Schedule] do
          @schedule = Schedule.find(params[:id])
          if @schedule.update(title: params[:title], content: params[:content],
                             starts_at: params[:starts_at], ends_at: params[:ends_at],
                             place: params[:place], hidden: params[:hidden])
            present @schedule
          else
            error!({ error: @schedule.errors.full_messages }, 400)
          end
        end

        desc 'delete a schedule'
        delete '', authorize: [:manage, Schedule] do
          @schedule = Schedule.find(params[:id])
          @schedule.destroy
          { ok: 1 }
        end

      end

    end

  end
end
