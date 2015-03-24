class PasswordsController < ApplicationController
  include SimpleCaptcha::ControllerHelpers

  layout 'layouts/visitor'

  def new
  end

  def create
    #TODO
    UserMailer.verify_email.deliver_now
    redirect_to action: :edit
  end

  def edit
    #TODO
  end

  def update
    #TODO
  end
end
