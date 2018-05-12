module V1
    class AuthAPI < Grape::API
  
        resource :auth do
    
            desc 'Get authentication token'
            params do
                requires :email, type: String, desc: 'Email'
                requires :password, type: String, desc: 'Password'
            end
            post 'token' do
                @user = User.find_by_email(params[:email])      
                if @user.valid_password?(params[:password])
                    { access_token: @user.authentication_token }
                else
                    error!({ error: @message.errors.full_messages }, 400)
                end
            end

        end
  
    end
  end
  