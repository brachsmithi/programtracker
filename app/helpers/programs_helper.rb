module ProgramsHelper

  def sort_programs programs
    programs.sort_by { |p| (p.sort_name.blank? ? p.name : p.sort_name).downcase }
  end

end
