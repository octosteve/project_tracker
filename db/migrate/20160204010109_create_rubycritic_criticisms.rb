class CreateRubycriticCriticisms < ActiveRecord::Migration
  def change
    create_table :rubycritic_criticisms do |t|
      t.string :commit_hash
      t.json :payload

      t.timestamps null: false
    end
    add_index :rubycritic_criticisms, :commit_hash
  end
end
