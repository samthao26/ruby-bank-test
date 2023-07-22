#!/usr/bin/env ruby

require 'selenium-webdriver'
require 'csv'
require 'pry'

options = Selenium::WebDriver::Options.firefox
options.headless!
driver = Selenium::WebDriver.for :firefox, options: options

driver.navigate.to "https://techcombank.com/en/tools-utilities/exchange-rates"

EXCHANGE_RATE_TABLE = "xpath=//div[contains(@class,'borderTop')]//p[contains(@class,'jZmT')]";
EXCHANGE_RATE = "//div[@class='ExchangeRateTable_borderTop__GWXcn']//p[contains(@class, 'ExchangeRateTable_pd16__TjZmT')]";
	
wait = Selenium::WebDriver::Wait.new(:timeout => 30)
wait.until { driver.find_element(xpath: EXCHANGE_RATE) }

table = driver.find_elements(xpath: EXCHANGE_RATE)

grouped_hash = table.group_by { |e| e.location.y }

csv_arr = grouped_hash.map do |key, value|
  value.map { |element| element.text }.to_csv
end

File.open("./techcom.csv", 'w') do |f|
  f.write("Currency, Buy (Cash), Buy (XFer), Sell\n")
  f.write(csv_arr.join())
end

driver.quit
