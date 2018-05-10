class User::SessionsController < Devise::SessionsController 
  layout 'blank'

  def create
    this_user = User.find_by(:email=>params[:user][:email])
    if !this_user.nil?
      begin       
        self.resource = warden.authenticate!(:scope=>:user)
        if sign_in(resource_name, resource)
          current_user.remember_me!
          @result = 'true'
          data = {:message => @result, :dr_name => current_user.dr_name, :user_id => current_user.id, :d_video => current_user.d_video, :d_audio => current_user.d_audio} 
        else 
          @result = 'Invalid Credentials' 
          data = {:message => @result}
        end
      rescue 
        data = {:message => 'Invalid Credentials'}
      end
    else 
      @result = 'Cannot find user with email ' + params[:user][:email]
      data = {:message => @result}
    end
    respond_to do |format|
        format.json { render :json => data, :status => :ok }
        format.html { respond_with resource, :location => after_sign_in_path_for(resource) } 
    end

  end
  protected
  def after_sign_in_path_for(resource)
    return root_path
  end
end
