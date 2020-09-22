module DiscsHelper

  def disc_display_name disc
    DiscsSearch.find(disc.id).display_title
  end

end
