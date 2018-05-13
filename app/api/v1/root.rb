module V1
  class Root < Grape::API
    version 'v1'

    default_error_formatter :json
    rescue_from :all do |e|
      case e
      when ActiveRecord::RecordNotFound
        Rack::Response.new([{ error: 'Record not found.' }.to_json], 404, {}).finish
      when Grape::Exceptions::ValidationErrors
        Rack::Response.new([{ error: 'Invalid parameters.' }.to_json], 400, {}).finish
      when CanCan::AccessDenied
        Rack::Response.new([{ error: 'Access Denied.' }.to_json], 401, {}).finish
      else
        Rails.logger.error "Api V1 Error: #{e}\n#{e.backtrace.join("\n")}"
        Rack::Response.new([{ error: 'API unavailable.' }.to_json], 500, {}).finish
      end
    end

    helpers V1::Helpers

    mount V1::AuthAPI
    mount V1::InstrumentsAPI
    mount V1::InventoriesAPI
    mount V1::MessagesAPI
    mount V1::SchedulesAPI
    mount V1::TopicsAPI
    mount V1::WikisAPI

    desc 'Test'
    params do
      optional :limit, type: Integer, values: 0..100
    end
    get 'hello' do
      { app: 'natty', apiver: 'v1' }
    end

  end
end
