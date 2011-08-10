class LeaguesController < ApplicationController

  before_filter :authenticate_create, :only => :create
  
  def index
    @title = "All leagues"
    @leagues = League.paginate(:page => params[:page])
  end
    
  def show
    @league = League.find(params[:id])
    @title = @league.name
    @entries = @league.entries.paginate(:page => params[:page])
  end
  
  def new
    @league = League.new
  end
  
  def create
    @league = League.new(:name => params[:league][:name], :password => params[:league][:password], :admin_id => current_user.id)
    if @league.save
      flash[:success] = "Thank you for creating your new league! Please continue to customize the league below."
      redirect_to @league
    else
      render :new
    end
  end
end