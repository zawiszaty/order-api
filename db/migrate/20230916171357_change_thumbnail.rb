class ChangeThumbnail < ActiveRecord::Migration[7.0]
  def change
    remove_column :products, :thumbnail_url
  end
end
