module ApplicationHelper

  def logo
    # Fill in.
    logo = image_tag("logo.png", :alt => "PicksLeague.com", :class => "logo")
  end  
  # Return a title on a per-page basis.
  def title
    base_title = "PicksLeague.com - Pick. Watch. Win."
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
