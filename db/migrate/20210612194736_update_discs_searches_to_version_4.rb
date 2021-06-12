class UpdateDiscsSearchesToVersion4 < ActiveRecord::Migration[6.0]
  def change
    update_view :discs_searches, version: 4, revert_to_version: 3
  end
end
