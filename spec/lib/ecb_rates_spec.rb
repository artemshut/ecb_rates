require 'spec_helper'

describe ECBRates do
  it "should return currency without date parameter for today" do
    rate_for_usd = ECBRates.rates_for 'usd'
    expect(rate_for_usd).not_to be_nil
  end

  it "should return weekend message" do
    rate_for_usd = ECBRates.rates_for 'usd', '12.09.2015'
    expect(rate_for_usd).to eq("######## No rate for this date. May be it was a weekend? ########")
  end

  it "should return incorrect currency message" do
    rate_for_usd = ECBRates.rates_for 'xxx', '14.09.2015'
    expect(rate_for_usd).to eq("######## Service have no such currency. Check it please. ########")
  end

  it "should return incorrect date message" do
    rate_for_usd = ECBRates.rates_for 'usd', Date.today + 20.years
    expect(rate_for_usd).to eq("######## The date should be in the past. ########")
  end
end
