# == Schema Information
#
# Table name: topics
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  content         :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#  published       :boolean
#  published_start :datetime
#  published_end   :datetime
#

require 'spec_helper'

describe Topic do
	it { should belong_to(:user)}
	it { should have_and_belong_to_many(:locations)}
	it { should have_many(:references)}

	before { 
		@topic = Topic.new(
			title: 	 "Example title", 
			content: "Topic topic topic, topic; topic topic topic."
		)
	}

	subject { @topic }

	it { should respond_to(:title) }
	it { should respond_to(:content) }

	it { should respond_to :versions } # check paper_trail attachment

	it { should be_valid }

	describe "when title is not present" do
		before { @topic.title = " " }
		it { should_not be_valid }
	end

	describe "when title is too long" do
		before { @topic.title = "a" * 101 }
		it {should_not be_valid }
	end


end
