require 'spec_helper'

describe ECBRates do
  it "should return valid currency parameter for 14.09.2015" do
    rate_for_usd = ECBRates.rates_for 'usd', '14.09.2015'
    expect(rate_for_usd).to eq(1.1305)
  end

  it "should return nil if weekend" do
    rate_for_usd = ECBRates.rates_for 'usd', '12.09.2015'
    expect(rate_for_usd).to be_nil
  end

  it "should return nil if incorrect currency" do
    rate_for_usd = ECBRates.rates_for 'xxx', '14.09.2015'
    expect(rate_for_usd).to be_nil
  end

  it "should return nil if incorrect date" do
    rate_for_usd = ECBRates.rates_for 'usd', Date.today + 20.years
    expect(rate_for_usd).to be_nil
  end
end
