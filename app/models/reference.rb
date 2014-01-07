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

require 'nokogiri'
require 'open-uri'

class Reference < ActiveRecord::Base
	attr_accessible :title, :creator, :year, :lang, :snippet, :url, :reference_source_id, :reference_type_id, :topic_id
	
	belongs_to :reference_source
	belongs_to :reference_type
	belongs_to :topic

	before_save :set_data_from_url

	private
		# Creates a Reference from the URL if it is the only available attribute.
		# Used by topics/new
		def set_data_from_url
			if self.title.nil? then
				tmp = ReferenceSource::new_reference_from(self.url)

				self.title = !tmp.nil? ? tmp.title : ''
				self.creator = !tmp.nil? ? tmp.creator : ''
				self.year = !tmp.nil? ? tmp.year : ''
				self.lang = !tmp.nil? ? tmp.lang : ''
				self.reference_type_id = !tmp.nil? ? tmp.reference_type_id : ''
			end
		end
end
