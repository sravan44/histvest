class ActiveExistingUsers < ActiveRecord::Migration
  def up
  	# set all existing users active
  	User.where("created_at <= ?",Time.local(2013,10,03)).update_all("status = 't'")
  end

  def down
  end
end
