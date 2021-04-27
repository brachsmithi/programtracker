module PackagesHelper

  def package_capsule_array(package)
    return_array = []
    package.contained_package_packages.each do |cpp|
      return_array << sequenced_package_capsule(cpp)
    end
    package.disc_packages.each do |dp|
      return_array << sequenced_disc_capsule(dp)
    end
    return_array.sort_by { |spc| spc[:seq] }
  end

  def capsule_program(program)
    version = program.version.blank? ? '' : " (#{program.version})"
    "#{program.name}#{version}"
  end

  private

  def sequenced_package_capsule(cpp)
    {
      display_capsule: cpp.contained_package.name,
      id: cpp.contained_package.id,
      path_method: 'package_path',
      seq: cpp.safe_sequence,
      type: 'Package'
    }
  end

  def sequenced_disc_capsule(dp)
    {
      display_capsule: disc_name(dp.disc.name),
      id: dp.disc.id,
      path_method: 'disc_path',
      seq: dp.safe_sequence,
      type: dp.disc.format,
      contents: disc_contents(dp.disc.programs)
    }
  end

  def disc_contents(programs)
    programs.map { |p| link_to capsule_program(p), program_path(p) }
  end

  def disc_name(name)
    name.blank? ? 'Untitled' : name
  end

end
