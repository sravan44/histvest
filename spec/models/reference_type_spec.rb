# == Schema Information
#
# Table name: reference_types
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  typestrings :string(255)
#

require 'spec_helper'

describe ReferenceType do
	it { should have_many(:references)}

	before { @reference_type = ReferenceType.new(
		name: "Example") 
	}

	subject { @reference_type }

	it { should respond_to(:name) }

	it { should be_valid }

	describe "when name is not present" do
		before { @reference_type.name = " " }
		it { should_not be_valid }
	end

	describe "when name is too long" do
		before { @reference_type.name = "a" * 51 }
		it {should_not be_valid }
	end
end
