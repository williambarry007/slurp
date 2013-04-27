class Slurp::UsersController < SlurpController
    
  # GET /users
  def index
    return if !user_is_allowed('users', 'view')
    
    @gen = PageBarGenerator.new(params, {
  		  'first_name'  => '',
  		  'last_name'		=> '',
  		  'username'	  => '',
  		  'email' 		  => '',
  		},{
  	    'sort'			  => 'last_name, first_name',
  		  'desc'			  => false,
  		  'base_url'		=> '/users'
  	})
  	
  	if (@gen.options['page'] == 0) 
  		@gen.options['item_count'] = User.where(@gen.where).count
  	end
  	@users = User.where(@gen.where).limit(@gen.limit).offset(@gen.offset).reorder(@gen.reorder).all
  end
  
  # GET /users/new
  def new
    return if !user_is_allowed('users', 'add')
    @user = User.new
  end
  
  # GET /users/1/edit
  def edit
    return if !user_is_allowed('users', 'edit')
    @user = User.find(params[:id])    
    @all_roles = Role.tree
    @roles = Role.roles_with_user(@user.id)
  end
  
  # POST /users
  def create
    return if !user_is_allowed('users', 'add')
    
    resp = StdClass.new({
        'error' => nil,
        'redirect' => nil
    })
    
    user = User.new()
    user.username = params[:username]
    
    if (user.username.length == 0)
      resp.error = "Your username is required."
    elsif      
      user.save
      resp.redirect = "/users/#{user.id}/edit"
    end
    render json: resp
  end
  
  # PUT /users/1
  def update
    return if !user_is_allowed('users', 'edit')
    
    resp = StdClass.new({ :text => '', :cancel_edit => false })    
    user = User.find(params[:id])
    field_id = params[:field_id]
    value = params[field_id]
    Kernel.log(value)
  
    save = true
    case field_id
  		when "first_name"
  		  user.first_name = value
  		when "last_name"
  		  user.last_name = value
  		when "username"
  		  user.username = value
  		when "email"
  		  user.email = value 
  		when "password"			  
  		  confirm = params[:confirm]
  			if (value != confirm)			
  			  resp.text = "<p class='note error'>Passwords do not match</p>";
  			  save = false
  			elsif (value.length < 8)
  			  resp.text = "<p class='note error'>Passwords must be at least 8 characters</p>";
  			  save = false
  			end
  
  		#case /roles/
  		#	$roleIDs = explode('|', $value);
  		#	AppUsers::updateMembership($this->userID, $roleIDs);
  		#	$roles = array();
  		#	foreach ($roleIDs as $roleID)
  		#	{
  		#		$role = Roles::getRole($roleID);
  		#		$roles[] = $role->name;
  		#	}
  		#	$resp->field_text = implode(', ', $roles); // Text to replace the form
  		#	$resp->text = "<p class='note success'>The role membership has been updated successfully.</p>";
  		#	$success = true;
  		#	break;		  
  	end
  	
  	if (save)
  	  resp.cancel_edit = user.save
  	end    
  	render json: resp
  end
  
  # DELETE /users/1
  def destroy
    return if !user_is_allowed('users', 'delete')
    user = User.find(params[:id])
    user.destroy
    redirect_to "/users"
  end
end