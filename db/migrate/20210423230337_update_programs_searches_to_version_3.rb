class UpdateProgramsSearchesToVersion3 < ActiveRecord::Migration[6.0]
  def change
    update_view :programs_searches, version: 3, revert_to_version: 2
  end
end
