require 'spec_helper'

describe EntriesController do
  render_views
  
  describe "POST 'create'" do
    
    before(:each) do
      @league = Factory(:league)
      #@user = test_sign_in(Factory(:user))
    end
    
    describe "not logged in" do
      
      it "should not create an entry" do
        lambda do
          post :create, :league => @league
        end.should_not change(League, :count)
      end
    end
  end
end