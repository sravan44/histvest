# == Schema Information
#
# Table name: reference_sources
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe ReferenceSource do
	it { should have_many(:references)}

	before { @reference_source = ReferenceSource.new(name: "Example") }

	subject { @reference_source }

	it { should respond_to(:name) }

	it { should be_valid }

	describe "when name is not present" do
		before { @reference_source.name = " " }
		it { should_not be_valid }
	end

	describe "when name is too long" do
		before { @reference_source.name = "a" * 51 }
		it {should_not be_valid }
	end

	describe ".search_all" do
		before { @result = ReferenceSource::search_all("svend") }

		subject { @result }

		it "should return array" do
			@result.should be_an_instance_of(Array)
		end

		it "should return array of References" do
			@result.each do |r|
				r.should be_an_instance_of(Reference)
			end
		end
	end
end
