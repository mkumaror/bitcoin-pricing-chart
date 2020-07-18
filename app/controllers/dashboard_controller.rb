class DashboardController < ApplicationController
  def index
  end

  def chart_data
  	data = {}
  	Pricing.all.each {|p| data = data.merge(p.data) }
  	data = Hash[data.sort_by {|k, v| k.to_i }]
  	
  	csv_contents = CSV.generate do |csv|
      csv << ['Time', 'Price($)', 'Market Cap($)']
      
      data.each do |k, obj| 
        csv << [ k.to_i, obj['price'], obj['market_cap']]
      end
    end
    send_data csv_contents, :filename => 'data.csv'
  end
end
