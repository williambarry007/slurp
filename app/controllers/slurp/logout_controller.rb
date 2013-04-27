class Slurp::LogoutController < SlurpController
  # GET /logout
  def index
    reset_session
    redirect_to "/"    
  end
end