class AddProjectReferenceToRubycriticCriticism < ActiveRecord::Migration
  def change
    add_reference :rubycritic_criticisms, :project, index: true, foreign_key: true
  end
end
