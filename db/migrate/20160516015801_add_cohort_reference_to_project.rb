class AddCohortReferenceToProject < ActiveRecord::Migration
  def change
    add_reference :projects, :cohort, index: true, foreign_key: true
  end
end
