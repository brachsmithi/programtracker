class AddProgramVersionClusterColumnToProgram < ActiveRecord::Migration[6.0]
  def change
    change_table :program_version_clusters do |t|
      add_reference :programs, :program_version_cluster, null: true, foreign_key: true
    end
  end
end
