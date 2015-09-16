require 'net/http'
require 'uri'
require 'active_support/core_ext/hash'
require 'date'

class ECBRates

  # URLs for daily/90 days/from 1999 response after calling ECB
  ECB_URL_DAILY = 'http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml'
  ECB_URL_90 = 'http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml'
  ECB_URL_FROM_BEGINNING = 'https://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist.xml'

  class << self

    # Example:
    #   >> ECBRates.rates_for 'usd', 14.09.2015
    #   => 1.2345
    #
    # Arguments:
    #   currency: (String)
    #   date: (String)
    def rates_for currency, date = Date.today
      converted_date = convert date
      if converted_date > Date.today.to_s
        puts "######## The date should be in the past. ########"
      else
        get_rate_for currency.upcase, converted_date
      end
    end

    #Parse xml response from ECB
    def get_rate_for currency, converted_date
      rates_for_period = Hash.from_xml(get_rates_from_ecb)
      rates_for_chosed_date = rates_for_period["Envelope"]["Cube"]["Cube"].detect { |h| h["time"] == converted_date }
      if rates_for_chosed_date
        rate_with_currency = rates_for_chosed_date["Cube"].detect { |h| h["currency"] == currency }
        if rate_with_currency && rate_with_currency["rate"]
          rate_with_currency["rate"].to_f
        else
          puts "######## Service have no such currency. Check it please. ########"
        end
      else
        puts "######## No rate for this date. May be it was a weekend? ########"
      end
    end

    # Return xml with response from ECB
    def get_rates_from_ecb
      uri = URI.parse ECB_URL_90
      http = Net::HTTP.new uri.host, uri.port
      request = Net::HTTP::Post.new uri.path
      response = http.request request
      response.body
    end

    # Convert date from parameters into a version, acceptable by ECB service
    def convert date; date.is_a?(String) ? Date.parse(date).to_s : date.to_s end

  end

end
