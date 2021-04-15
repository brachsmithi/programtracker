module DiscsHelper

  def disc_display_name disc
    DiscsSearch.find(disc.id).display_title
  end

  def disc_index_capsule discs_search
    package = discs_search.package_name.nil? ? "" : "[#{discs_search.package_name}] "
    "#{package}#{discs_search.display_title} - #{discs_search.format} (#{discs_search.location.name})"
  end

end
