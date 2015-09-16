require 'spec_helper'

describe ECBRates do
  it "should return currency without date parameter for today" do
    rate_for_usd = ECBRates.rates_for 'usd'
    expect(rate_for_usd).not_to be_nil
  end

  it "should return weekend message" do
    rate_for_usd = ECBRates.rates_for 'usd', '12.09.2015'
    expect(rate_for_usd).to be_nil
  end

  it "should return incorrect currency message" do
    rate_for_usd = ECBRates.rates_for 'xxx', '14.09.2015'
    expect(rate_for_usd).to be_nil
  end

  it "should return incorrect date message" do
    rate_for_usd = ECBRates.rates_for 'usd', Date.today + 20.years
    expect(rate_for_usd).to be_nil
  end
end
