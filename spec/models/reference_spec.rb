# Encoding: UTF-8
# == Schema Information
#
# Table name: references
#
#  id                  :integer          not null, primary key
#  title               :string(255)
#  creator             :string(255)
#  year                :integer
#  lang                :string(255)
#  snippet             :string(255)
#  url                 :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  reference_type_id   :integer
#  reference_source_id :integer
#  topic_id            :integer
#

require 'spec_helper'

describe Reference do

	before { @ref = Reference.new(
		title: "Svend Foyn - et mindeskrift", 
		creator: "Klæbo", 
		year: 1895, 
		lang: "und")
	}

	subject { @ref }

	it { should belong_to(:reference_type) }
	it { should belong_to(:reference_source) }
	it { should belong_to(:topic) }

	it { should respond_to(:title) }
	it { should respond_to(:creator) }
	it { should respond_to(:year) }
	it { should respond_to(:lang) }
	it { should respond_to(:snippet) }
	it { should respond_to(:url) }

	it { should be_valid }

	describe "it should be possible to create from URL" do
		before {
			@new_ref = Reference.new(url: "http://urn.nb.no/URN:NBN:no-nb_digibok_2009031003030")
			@new_ref.save
		}

		it "with correctly fetched data" do
			@new_ref.title.should == "Svend Foyn : et mindeskrift"
			@new_ref.creator.should == "Klæboe, Hans B."
			@new_ref.lang.should == "und"
			@new_ref.year.should == 1895 
		end
	end
end
