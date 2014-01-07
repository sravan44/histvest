class WrapperHelper
	def self.fetch_http(url)
		return Net::HTTP.get(URI.parse(url))
	end
end
