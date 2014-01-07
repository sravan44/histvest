# Encoding: UTF-8
require 'spec_helper'

describe NationalLibraryWrapper do
	describe ".search" do

		nlw = NationalLibraryWrapper.new("svend foyn")
		before { @result = nlw.search }

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

	describe ".new_reference_from" do

		before { @ref = NationalLibraryWrapper::new_reference_from("http://urn.nb.no/URN:NBN:no-nb_digibok_2009031003030") }

		subject { @ref }

		it "should be a reference" do
			@ref.should be_an_instance_of(Reference)
		end

		it "should have correct info" do
			@ref.title.should == "Svend Foyn : et mindeskrift"
			@ref.creator.should == "Klæboe, Hans B."
			@ref.lang.should == "und"
			@ref.year.should == 1895 
		end
	end
end
