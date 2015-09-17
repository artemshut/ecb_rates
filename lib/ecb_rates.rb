require 'net/http'
require 'uri'
require 'active_support/core_ext/hash'
require 'date'
require 'logger'

class ECBRates

  # URLs for daily/90 days/from 1999 response after calling ECB
  ECB_URL_DAILY = 'http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml'
  ECB_URL_90 = 'http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml'
  ECB_URL_FROM_BEGINNING = 'https://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist.xml'

  class << self

    # Example:
    #   >> ECBRates.rates_for 'usd', '14.09.2015'
    #   => 1.2345
    #
    # Arguments:
    #   currency: (String)
    #   date: (String)
    def rate(currency, date = Date.today)
      converted_date = date_processing(date)
      return unless converted_date
      rates_for_chosen_date = parsed_ecb_rates(converted_date)
      if rates_for_chosen_date
        rate_with_currency = rates_for_chosen_date["Cube"].detect { |h| h["currency"] == currency.upcase }
        check_result(rate_with_currency)
      else
        write_log('No rate for this date. May be it was a weekend or rate not updated yet?')
      end
    end

    private

    # Return xml with response from ECB
    def ecb_rates
      uri = URI.parse(ECB_URL_90)
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.path)
      response = http.request(request)
      response.body
    end

    # Return hash parsed from xml response from ECB
    def parsed_ecb_rates(converted_date)
      rates_for_period = Hash.from_xml(ecb_rates)
      rates_for_period["Envelope"]["Cube"]["Cube"].detect { |h| h["time"] == converted_date }
    end

    # Return currency value if present or no rate message
    def check_result(rate_with_currency)
      if rate_with_currency && rate_with_currency["rate"]
        rate_with_currency["rate"].to_f
      else
        write_log('Service have no such currency. Check it please.')
      end
    end

    # Convert date from parameters into a version, acceptable by ECB service
    def date_processing(date)
      begin
        converted_date = date.is_a?(String) ? Date.parse(date).to_s : date.to_s
        if converted_date > Date.today.to_s || converted_date < '1999-01-01'
          write_log('Date is not correct.')
        else
          converted_date
        end
      rescue => e
        write_log(e.message)
      end
    end

    def write_log(message)
      logger = Logger.new(STDOUT)
      logger.level = Logger::WARN
      logger.warn(message)
      nil
    end

  end

end
