require 'finnhub_ruby'

FinnhubRuby.configure do |config|
  config.api_key['api_key'] = ''
end

finnhub_client = FinnhubRuby::DefaultApi.new
puts(finnhub_client.quote('AAPL'))


# require 'net/http'
# require 'uri'
# require 'json'

# # Function to fetch stock data
# def fetch_stock_data(symbol, api_key)
#   uri = URI("https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=#{symbol}&interval=1min&apikey=#{api_key}")
#   response = Net::HTTP.get(uri)
#   JSON.parse(response)
# end

# api_key = 'UKCI6D6O18GBV4FJ'
# stock_symbol = 'IBM'

# begin
#   data = fetch_stock_data(stock_symbol, api_key)
  
#   if data["Time Series (Daily)"]
#     puts "Date: #{data["Time Series (Daily)"].keys.first}"
#     puts "Open: #{data["Time Series (Daily)"].values.first["1. open"]}"
#     puts "High: #{data["Time Series (Daily)"].values.first["2. high"]}"
#     puts "Low: #{data["Time Series (Daily)"].values.first["3. low"]}"
#     puts "Close: #{data["Time Series (Daily)"].values.first["4. close"]}"
#     puts "Volume: #{data["Time Series (Daily)"].values.first["5. volume"]}"
#   else
#     puts "Failed to fetch data: #{data["Note"] || data["Information"]}"
#   end
# rescue => e
#   puts "An error occurred: #{e.message}"
# end
