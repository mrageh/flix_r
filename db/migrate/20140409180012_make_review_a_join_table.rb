class MakeReviewAJoinTable < ActiveRecord::Migration
  def up
    Review.destroy_all
    remove_column :reviews, :full_name
    add_column :reviews, :user_id, :integer
  end

  def down
    Review.destroy_all
    remove_column :reviews, :user_id
    add_column :reviews, :full_name, :string
  end
end
