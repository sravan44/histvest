class AddImageToAvatar < ActiveRecord::Migration
  def change
    add_attachment :avatars, :avatar_img
  end
end
