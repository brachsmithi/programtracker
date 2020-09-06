class CreateProgramVersionClusters < ActiveRecord::Migration[6.0]
  def change
    create_table :program_version_clusters do |t|

      t.timestamps
    end
  end
end
