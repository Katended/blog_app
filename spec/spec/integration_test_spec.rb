# spec/integration_test_spec.rb
require 'selenium-webdriver'

describe 'Integration Test' do
  before(:all) do
    @driver = Selenium::WebDriver.for :chrome
  end

  after(:all) do
    @driver.quit
  end

  it 'visits a website and checks the title' do
    @driver.get('https://www.example.com')
    expect(@driver.title).to eq('Example Domain')
  end
end
