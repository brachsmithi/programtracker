module PackagesHelper

  def capsule_program program
    version = program.version.blank? ? '' : " (#{program.version})"
    "#{program.name}#{version}"
  end

end
