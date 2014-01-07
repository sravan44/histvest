require 'json'
require 'uri'
require 'open-uri'
require 'net/http'

# Wrapper around Europeana
class EuropeanaWrapper

	def initialize(query)
		@query = query
		@doc = fetch_doc(1)
		number_of_results
	end

	def search(page = 0)
		@doc = fetch_doc(page)

		if @doc['itemsCount'] < 1
			return Array.new
		end
		
		@doc['items'].map do |i|

			title = ""
			if i['title']
				title = i['title'].first
			end

			Reference.new(
				'reference_source_id' => 3,
				'reference_type_id' => ReferenceType.determine_type_id(i['type'].to_s.downcase),
				'title'  => title,
				'creator' => 'Europeana',
				'lang'    => i['language'].first,
				'snippet' => title,
				'url'    => i['guid'],
				'year'    => nil
			)
		end
	end

	def number_of_results
		return @doc['totalResults'].to_i
	end

	def self.new_reference_from(url)

		id = url.scan(/\d{1,8}\/\w*/).first

		apikey = ENV['EUROPEANA_KEY']

		api_url = "http://www.europeana.eu/api/v2/record/#{id}.json?wskey=#{apikey}&profile=full"

		data = WrapperHelper::fetch_http(api_url)

		result = JSON.parse(data)

		if result['object']['proxies'][0]['dcTitle'] != nil
			if result['object']['proxies'][0]['dcTitle']['def'] != nil
				title = result['object']['proxies'][0]['dcTitle']['def'].first
			else
				title = result['object']['proxies'][0]['dcTitle'].flatten.last
				if title.class == Array
					title = title.last
				end
			end
		else
			title = ""
		end

		if result['object']['proxies'][0]['dcDescription'] != nil
			if result['object']['proxies'][0]['dcDescription']['def'] != nil
				snippet = result['object']['proxies'][0]['dcDescription']['def'].first
			else
				snippet = result['object']['proxies'][0]['dcDescription'].flatten.last
				if snippet.class == Array
					snippet = snippet.last
				end
			end
		else
			snippet = ""
		end

		if result['object']['proxies'][0]['dcCreator'] != nil
			if result['object']['proxies'][0]['dcCreator']['def'] != nil
				creator = result['object']['proxies'][0]['dcCreator']['def'].first
			else
				creator = result['object']['proxies'][0]['dcCreator'].flatten.last
				if creator.class == Array
					creator = creator.last
				end
			end
		else
			if result['object']['proxies'][0]['dcSource'] != nil
				if result['object']['proxies'][0]['dcSource']['def'] != nil
					creator = result['object']['proxies'][0]['dcSource']['def'].first
				else
					creator = result['object']['proxies'][0]['dcSource'].flatten.last
					if creator.class == Array
						creator = creator.last
					end
				end
			else
				creator = ""
			end
		end

		if result['object']['proxies'][0]['dcType'] != nil
			if result['object']['proxies'][0]['dcType']['def'] != nil
				reference_type = result['object']['proxies'][0]['dcType']['def'].first
			else
				reference_type = result['object']['proxies'][0]['dcType'].flatten.last
				if reference_type.class == Array
					reference_type = reference_type.last
				end
			end
		else
			reference_type = "Unknown"
		end

		lang = result['object']['europeanaAggregation']['edmLanguage']['def'].first

		Reference.new(
			'reference_source_id' => 3,
			'reference_type_id'   => ReferenceType::determine_type_id(reference_type),
			'title'  => title,
			'creator' => creator,
			'lang'    => lang,
			'snippet' => title,
			'url'    => url,
			'year'    => nil
		)
	end

	def self.determine_type_id_from_url(url)
		id = url.scan(/\d{1,8}\/\w*/).first

		apikey = 'U4YHdx6jK'

		api_url = "http://www.europeana.eu/api/v2/record/#{id}.json?wskey=#{apikey}&profile=full"

		data = WrapperHelper::fetch_http(api_url)

		result = JSON.parse(data)

		if result['object']['proxies'][0]['dcType'] != nil
			if result['object']['proxies'][0]['dcType']['def'] != nil
				reference_type = result['object']['proxies'][0]['dcType']['def'].first
			else
				reference_type = result['object']['proxies'][0]['dcType'].flatten.last
				if reference_type.class == Array
					reference_type = reference_type.last
				end
			end
		else
			reference_type = "Unknown"
		end

		return ReferenceType::determine_type_id(reference_type)
	end

	private

	def fetch_doc(page = 0)
		itemsPerPage = 10
		startIndex = page * itemsPerPage
		if startIndex == 0
			startIndex = 1 
		end

		apikey = 'U4YHdx6jK'
		q = URI.encode(@query)

		url = "http://www.europeana.eu/api/v2/search.json?wskey=#{apikey}&query=#{q}&start=#{startIndex}&rows=#{itemsPerPage}&profile=standard"

		data = WrapperHelper::fetch_http(url)

		return JSON.parse(data)
	end
end