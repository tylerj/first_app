class UsersController < ApplicationController

  before_filter :authenticate,     :except => [:new, :create]
  before_filter :correct_user,     :only   => [:edit, :update]
  before_filter :correct_or_admin, :only   => :show
  before_filter :admin_user,       :only   => [:destroy, :index]
  before_filter :signed_in_user,   :only   => [:new, :create]
  
  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end
  
  def new
    redirect_to root_path if signed_in?
    @user = User.new
    @title = "Sign up"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Picks League!"
      redirect_back_or @user
    else
      @title = "Sign up"
      @user.password = nil
      @user.password_confirmation = nil
      render 'new'
    end
  end
  
  def edit
    @title = "Edit user"
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    unless current_user?(user)
      user.destroy
      flash[:success] = "User destroyed."
    end
    redirect_to users_path
  end

  private
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def correct_or_admin
      @user = User.find(params[:id])
      unless current_user?(@user) || current_user.admin?
        flash[:notice] = "You can not view other users' profiles"
        redirect_to(root_path) 
      end
    end
    
    def admin_user
      unless current_user.admin?
        flash[:notice] = "Only site administrators can view a list of all users"
        redirect_to(root_path)
      end
    end
    
    def signed_in_user
      redirect_to(root_path) if signed_in?
    end
end
