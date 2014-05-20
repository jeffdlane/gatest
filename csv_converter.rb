require 'csv'
 
class String
  def camel_case
    words = self.split.map(&:capitalize)
    words.first.downcase!
    words.join
  end

  def bingify
    words = self.camel_case
    words.gsub!(/(Spend|Impr\.)/, 'Spend' => 'Cost', 'Impr.' => 'impressions')
  end
end
 
module GA
  class CSV < CSV
    # https://developers.google.com/analytics/devguides/platform/cost-data-import#dims_mets
    VALID_HEADERS = %w( source
                        medium
                        campaign
                        adwordsCampaignId
                        adGroup
                        keyword
                        adMatchedQuery
                        adContent
                        referralPath
                        adwordsCriteriaId
                        adSlot
                        adSlotPosition
                        adDisplayUrl
                        adDestinationUrl
                        adCost
                        adClicks
                        impressions )
 
    SKIP_LINES = /^Total|^"Keyword/
 
    HeaderConverters[:best_try] = lambda do |header|
      valid_header = VALID_HEADERS.find do |valid|
        [header.camel_case, "ad #{header}".camel_case].include?(valid)
      end
      "ga:#{valid_header}" if valid_header
    end
    
    class << self
      def new(file)
        super(file, headers:            true,
                    header_converters:  :best_try,
                    converters:         :all,
                    skip_lines:         SKIP_LINES)
      end
    end
 
    def read
      super.by_col.delete_if { |k,v| k.nil? }
    end
  end
end
 
puts GA::CSV.new(open('keywords.csv')).read