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

require 'spec_helper'

describe Rejection do 

	it { should belong_to :user }
	it { should belong_to :topic }

	it { should respond_to :reason }
	it { should respond_to :unchanged }

	before { @rejection = Rejection.new	}

	describe "new rejection should be unchanged" do
		it { @rejection.unchanged.should == true }
	end

end
