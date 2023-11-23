class CreateBookmarks < ActiveRecord::Migration[7.1]
  def change
    # create_join_table :movies, :lists, table_name: :bookmarks do |t|
    #   t.string :comment
    #   t.index :movie_id
    #   t.index :list_id
    create_table :bookmarks do |t|
      t.string :comment
      t.belongs_to :movie, null: false, index:true, foreign_key: true
      t.belongs_to :list, null: false, index:true, foreign_key: true

      t.timestamps
    end
  end
end
