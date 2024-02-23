# This migration adds the optional `object_changes` column, in which PaperTrail
# will store the `changes` diff for each update event. See the readme for
# details.
class CreateFilterCombinations < ActiveRecord::Migration<%= migration_version %>
  def up
    create_table :filter_combinations do |t|
      t.belongs_to :spree_taxon
    end
  end

  def down
    remove_table :filter_combinations
  end
end
