module DirectorHelper

  def sort_directors director_arr
    director_arr.sort_by { |d| d.name.split(' ').last }
  end

end
