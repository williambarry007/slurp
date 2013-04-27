class Slurp::LoginController < SlurpController
  # GET /login
  def index
    @return_url = params[:return_url].nil? ? "/" : params[:return_url];
    redirect_to @return_url if logged_in?
  end
  
  # POST /login
  def login
    
    @resp = StdClass.new('error' => '', 'redirect' => '')
    @return_url = params[:return_url].nil? ? "/" : params[:return_url]
    
    if (logged_in?)
      @resp.error = "Already logged in"
    else
      @username = params[:username]
      @password = params[:password]
                         
      if (@username.nil? || @password.nil? || @password.strip.length == 0)
        @resp.error = "Invalid credentials"
      else
        
        @salt = Rails.configuration.salt
        @password = Digest::SHA1.hexdigest(@salt + @password)
        user = User.where(:username => @username, :password => @password).first
        
        if (user.nil?)
          @resp.error = "Invalid credentials"
        else
          login_user(user)
          @resp.redirect = @return_url
        end
      end
    end
    render json: @resp
  end
end