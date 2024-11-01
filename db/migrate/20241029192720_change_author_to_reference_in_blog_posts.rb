class ChangeAuthorToReferenceInBlogPosts < ActiveRecord::Migration[6.1]
    def change
      remove_column :blog_posts, :author
      add_reference :blog_posts, :author, foreign_key: { to_table: :users }
    end
end