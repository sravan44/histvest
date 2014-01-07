# Encoding: UTF-8
require 'spec_helper'
require 'openssl'

describe WikipediaWrapper do
	describe ".search" do
		ww = WikipediaWrapper.new("svend foyn")
		before { @result = ww.search() }

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

		before { @ref = WikipediaWrapper::new_reference_from("http://no.wikipedia.org/wiki/Svend_Foyn") }

		subject { @ref }

		it "should be a reference" do
			@ref.should be_an_instance_of(Reference)
		end

		it "should have correct info" do
			@ref.title.should == "Svend Foyn"
			@ref.creator.should == "Wikipedia"
			@ref.lang.should == "no"
			@ref.year.should == nil
		end
	end
end
