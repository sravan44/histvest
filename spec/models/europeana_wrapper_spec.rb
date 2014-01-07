# Encoding: UTF-8
require 'spec_helper'

 describe EuropeanaWrapper do
 	describe ".search" do
 		ew = EuropeanaWrapper.new("svend foyn")
 		before { @result = ew.search(0) }
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
 		url = "http://www.europeana.eu/portal/record/2022609/3701E9A913A319B8B3154E5A5340F31DECBA883A.html?utm_source=api&utm_medium=api&utm_campaign=U4YHdx6jK"
 		before { @ref = EuropeanaWrapper::new_reference_from(url) }
 		subject { @ref }
 		it "should be a reference" do
 			@ref.should be_an_instance_of(Reference)
 		end
 		it "should have correct info" do
 			@ref.title.should == "Vardås fort, et tysk kystfort på Nøtterøy"
 			@ref.creator.should == "Yngvar Halvorsen"
 			@ref.lang.should == "no"
 			@ref.year.should == nil
 			@ref.reference_type_id.should == 14
 			@ref.url.should == url
 		end
 	end
 	describe ".new_reference_from with inconsistent api" do
 		url = "http://www.europeana.eu/portal/record/2021002/C_536_3A2.html?utm_source=api&utm_medium=api&utm_campaign=U4YHdx6jK"
 		before { @ref = EuropeanaWrapper::new_reference_from(url) }
 		subject { @ref }
 		it "should be a reference" do
 			@ref.should be_an_instance_of(Reference)
 		end
 		it "should have correct info" do
 			@ref.title.should == "Lucifer (Päivä)"
 			@ref.creator.should == "Volpato, Giovanni (taiteilija)"
 			@ref.lang.should == "fi"
 			@ref.year.should == nil
 			@ref.reference_type_id.should == 14
 			@ref.url.should == url
 		end
 	end
 end
