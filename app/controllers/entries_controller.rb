class EntriesController < ApplicationController
  
  before_filter :authenticate_join, :only => :create
  
  def new
    @entry = Entry.new
    @title = "Join League"
  end
  
  def create
    # First, find the league that the user is trying to enter
    if @league = League.find_by_id(params[:entry][:league_id])
      # If the password provided matches the password of the league, then we're golden
      if @league.password == params[:entry][:league_password]
        @entry = @league.create_new_entry(current_user)
        if @entry.save
          flash.now[:success] = "You successfully joined the league"
          redirect_to @league
        else
          redirect_to root_path
        end
      # Otherwise, we need them to try again
      else
        @entry = Entry.new
        flash.now[:error] = "That password does not match the league password #{params[:entry][:league_password]} vs #{@league.password}"
        render :new
      end
    
    # If we did not find a league matching the provided ID:
    else
      @entry = Entry.new
      flash.now[:error] = "We do not have a league that matches that ID.  Please try again."
      render :new
    end
  end
end