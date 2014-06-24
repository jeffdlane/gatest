require 'csv'
 
module GoogleAnalytics
  class CSVConverter

    def self.convert(string,source,medium)
      CSV::HeaderConverters[:from_hash] = lambda do |header|
        header_conversions[header]
      end
      table = CSV.new(string, skip_lines:         skip_lines,
                              headers:            true,
                              header_converters:  :from_hash,
                              converters:         :all).read
      table.by_col.delete_if { |k,v| k.nil? }
      table['ga:source'] = source
      table['ga:medium'] = medium
      table.to_s
    end
  end

  class BingCSVConverter < CSVConverter

    def self.skip_lines

    end

    def self.header_conversions
      { 'Spend' => 'ga:adCost',
        'Impr.' => 'ga:impressions',
        'Campaign' => 'ga:campaign',
        'Ad group' => 'ga:adGroup',
        'Keyword' => 'ga:keyword',
        'Clicks' => 'ga:adClicks',
      }
    end
  end

puts GoogleAnalytics::ExampleCSVConverter.convert(open('in.csv').read, 'bing')

end
 