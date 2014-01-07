# == Schema Information
#
# Table name: rejections
#
#  id         :integer          not null, primary key
#  topic_id   :integer
#  user_id    :integer
#  reason     :text
#  unchanged  :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Rejection < ActiveRecord::Base

	belongs_to :user
	belongs_to :topic

end
