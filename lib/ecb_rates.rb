require 'nokogiri'
require 'net/http'
require 'active_support/core_ext/hash'
require 'uri'
require 'date'

class ECBRates
  ECB_URL_DAILY = 'http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml'
  ECB_URL_90 = 'http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml'
  ECB_URL_FROM_BEGINNING = 'https://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist.xml'
  #TODO: add extension to check allowed currencies
  class << self

    def rates_for currency, date = Date.today
      if date > Date.today
        puts "The date should be in the past"
      else
        get_rate_of currency.upcase, date
      end
    end

    def get_rate_of currency, date
      uri = URI.parse ECB_URL_90
      http = Net::HTTP.new uri.host, uri.port
      request = Net::HTTP::Post.new uri.path
      response = http.request request
      hash_of_currencies = Hash.from_xml(response.body)

      #TODO: check if date == date.today not convert
      query_date = Date.parse(date).to_s
      hash_by_day = hash_of_currencies["Envelope"]["Cube"]["Cube"].detect { |f| f["time"] == query_date }
      if hash_by_day.present?
        rates_list = hash_by_day["Cube"].detect { |f| f["currency"] == currency }
        if rates_list.present?
          rates_list["rate"].to_f
        else
          puts "No needed currency in list. Try another one."
        end
      else
        puts "There was a weekend on chosed date"
      end
    end
  end

end
