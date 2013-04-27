# Parent of all slurp controllers
class SlurpController < Slurp.parent_controller.constantize
  protect_from_forgery  
  before_filter :set_logged_in_user
  
  # Sets an instance variable of the logged in user
  def set_logged_in_user
    @logged_in_user = logged_in_user
  end
  
  # Logs in a user
  def login_user(user)
    session["app_user"] = user
  end
  
  # Returns whether or not a user is logged in
  def logged_in?
    #return true if !session["app_user"].nil? && session["app_user"].id != -1
    validate_token
    return true if !session["app_user"].nil? && session["app_user"].id != -1    
    return false
  end
  
  # Checks to see if a token is given. If so, it tries to validate the token 
  # and log the user in.
  def validate_token
    token = params[:token]
    return false if token.nil?
    
    user = User.validate_token(token)
    return false if user.nil?
   
    login_user(user)
    return true
  end
  
  # Returns the currently logged in user
  def logged_in_user
    return nil if !logged_in?
    return session["app_user"]
  end
  
  # Checks to see if a user has permission to perform the given action 
  # on the given resource.
  # Redirects to login if not logged in.
  # Redirects to error page with message if not allowed.
  def user_is_allowed(resource, action)
    if (!logged_in?)
      redirect_to "/login?return_url=" + URI.encode(request.fullpath)
      return
    end
    
    @user = logged_in_user
    if (!@user.is_allowed(resource, action))
      @error = "You don't have permission to " + action + " " + resource
      render :template => "extras/error"
      return false
    end
    
    return true    
  end
  
  # Removes a given parameter from a URL querystring
  def reject_param(url, param)
    arr = url.split('?')
    return url if (arr.count == 1)
    qs = arr[1].split('&').reject { |pair| pair.split(/[=;]/).first == param }
    url2 = arr[0]
    url2 += "?" + qs.join('&') if qs.count > 0 
    return url2
  end
  
  #def auth_or_error(message)
  #  if (!logged_in?)
  #    redirect_to "/login?return_url=#{request.request_uri}" and return false
  #  end
  #  redirect_to "/error?message=#{message}"
  #end
  
  def var(key)
    v = Var.where(:key => key).first
      return "" if v.nil?    
    return v.val
  end
end
