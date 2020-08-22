module DiscsHelper

  def sort_discs disc_arr
    disc_arr.sort_by { |d| trim_article(d.display_name).downcase }
  end

  private

  def trim_article value
    if value.start_with? 'A '
      value.delete_prefix 'A '
    elsif value.start_with? 'An '
      value.delete_prefix 'An '
    elsif value.start_with? 'The '
      value.delete_prefix 'The '
    else
      value
    end
  end

end
