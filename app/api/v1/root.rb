require 'doorkeeper/grape/helpers'

module V1
  class Root < Grape::API
    version 'v1'

    default_error_formatter :json
    rescue_from :all do |e|
      case e
      when Mongoid::Errors::DocumentNotFound
        Rack::Response.new([{ error: 'Record not found.' }.to_json], 404, {}).finish
      when Grape::Exceptions::ValidationErrors
        Rack::Response.new([{
          error: 'Invalid parameters.',
          validation_errors: e.full_messages
        }.to_json], 400, {}).finish
      when CanCan::AccessDenied
        Rack::Response.new([{
          error: 'Access Denied.',
        }.to_json], 401, {}).finish
      else
        Rails.logger.error "Api V3 Error: #{e}\n#{e.backtrace.join("\n")}"
        Rack::Response.new([{ error: "API unavailable" }.to_json], 500, {}).finish
      end
    end

    helpers Doorkeeper::Grape::Helpers
    helpers V1::Helpers

    mount V1::Messages

    desc 'Test'
    params do
      optional :limit, type: Integer, values: 0..100
    end
    get 'hello' do
      { app: 'rtiss', apiver: 'v1' }
    end

  end
end
