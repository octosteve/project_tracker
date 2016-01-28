class CreateHackers < ActiveRecord::Migration
  def change
    create_table :hackers do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :token

      t.timestamps null: false
    end
  end
end
