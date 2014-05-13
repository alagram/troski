class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name

      t.timestamps

      create_table :tags_tickets, id: false do |t|
        t.integer :tag_id, :ticket_id
      end
    end
  end
end
