class CreateRailsBestPracticeViolations < ActiveRecord::Migration
  def change
    create_table :rails_best_practice_violations do |t|
      t.references :project, index: true, foreign_key: true
      t.string :commit_hash, index: true
      t.string :violation
      t.string :message
      t.string :more_info_url
      t.string :file_name
      t.integer :line_number

      t.timestamps null: false
    end
  end
end
