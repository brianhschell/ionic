class User::RegistrationsController < Devise::RegistrationsController
  layout 'blank'
  skip_before_action :require_no_authentication, only: [:new, :create]

# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        if resource == User
          resource.account_id = params[:account]
          resource.save
        end
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        if resource.class == User
          resource.account_id = params[:account]
          resource.is_admin = params[:is_admin] if params[:is_admin].present?
          resource.save
        end
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      @message = resource.errors.full_messages.each {|x| flash[x] = x} # Rails 4 simple way
      redirect_to add_account_accounts_path(:message=>@message, :account=>params[:account], :t=>'user')
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  def after_update_path_for(resource)
    root_path
  end

  # The path used after sign up for inactive accounts.
   def after_inactive_sign_up_path_for(resource)
     add_account_accounts_path(:account=>params[:account],:t=>'user', :message=>'Invitation has been sent') 
   end
end
