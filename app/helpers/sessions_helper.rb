module SessionsHelper

  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    self.current_user = user
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= user_from_remember_token
  end
  
  def current_user_name
    @current_user.name ||= user_from_remember_token.name
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end
  
  def signed_in_user
    redirect_to root_path if signed_in?
  end

  def authenticate
    deny_access("default") unless signed_in?
  end
  
  def authenticate_join
    deny_access("join") unless signed_in?
  end
  
  def authenticate_create
    deny_access("create") unless signed_in?
  end
  
  def deny_access(type)
    store_location(type)
    notice_def = notice_type(type)
    redirect_to signin_path, :notice => notice_def
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end
  
  private
    
    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end
    
    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end
    
    def store_location(type)
      if type == "join"
        session[:return_to] = new_entry_path
      elsif type == "create"
        session[:return_to] = new_league_path
      else
        session[:return_to] = request.fullpath
      end
    end
    
    def notice_type(type)
      if type == "join"
        return "Please sign in or create an account to join this league."
      elsif type == "create"
        return "Please sign in or create an account to start a new league."
      else
        return "Please sign in to access this page."
      end  
    end
    
    def clear_return_to
      session[:return_to] = nil
    end
end