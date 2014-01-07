require 'nokogiri'
require 'uri'
require 'open-uri'
require 'openssl'

# Wrapper around Wikipedia
class WikipediaWrapper
	def initialize(query)
		@query = query
		@doc = fetch_doc(0)
		@total_results = number_of_results
	end

	def number_of_results
		# Matches last digits in string of form: <subtitle type=\"text\">Nasjonalbibliotekets general Search API for client applications, results: 1 - 10 of 565</subtitle>
		return @doc.css("div.results-info").text.scan(/\d+/).last.to_i
	end

	def search(page=0)
		fetch_doc(page).css(".mw-search-results li").map do |r|
			Reference.new(
				'title'   => r.css(".mw-search-result-heading").text.strip,
				'reference_source_id' => 2,
				'reference_type_id' => ReferenceType.determine_type_id('article'),
				'snippet' => r.css(".searchresult").text[0,249],
				'year'    => nil,
				'url'     => 'http://no.wikipedia.org' + r.css(".mw-search-result-heading a").attr("href"),
				'lang'    => 'no',
				'creator' => 'Wikipedia'
			)
		end
	end

	def  self.new_reference_from(url)
		doc = Nokogiri::XML(WrapperHelper::fetch_http(url))

		Reference.new(
			'reference_source_id' => 2,
			'reference_type_id'   => ReferenceType.determine_type_id('article'),
			'title'               => doc.css('#firstHeading').text,
			'creator'             => 'Wikipedia',
			'lang'                => 'no',
			'snippet'             => doc.css('#mw-content-text').text[0,249],
			'url'                 => url,
			'year'                => nil
		)
	end

	# very simple as wikipedia only support articles
	def self.determine_type_id_from_url(url)
		return ReferenceType::determine_type_id("article")
	end

	private

	def fetch_doc(page)
		results_per_page = 10
		offset = page * results_per_page

		# Encode whitespace to allow multiple words in query
		return Nokogiri::XML(WrapperHelper::fetch_http("http://no.wikipedia.org/w/index.php?title=Spesial:S%C3%B8k&limit=#{results_per_page}&offset=#{offset}&redirs=1&profile=default&search=" + URI.encode(@query)))
	end
end