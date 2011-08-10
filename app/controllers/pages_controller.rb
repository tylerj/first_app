class PagesController < ApplicationController
  def home
    @title = "Home"
    @entry = Entry.new
    @league = League.new
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end

  def faq
    @title = "FAQ"
  end

end
