module ProgramVersionClustersHelper

  def program_version_cluster_capsule(pvc)
    if pvc.programs.any?
      versions = pvc.programs.map(&:version).join(', ')
      "#{pvc.programs.first.name} - #{versions}"
    else
      '--NO PROGRAMS--'
    end
  end

end
