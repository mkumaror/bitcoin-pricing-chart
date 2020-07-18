module Services
  class Pricing
    
    def initialize
      #to initialize class parameters
    end

    def fetch_latest_pricing
      time = DateTime.now.strftime("%d/%m/%Y %H:%M")
      api_url = "#{ENV['API_BASE_URL']}/v1/cryptocurrency/listings/latest"
      response = get(api_url, {"start"=>1, "limit"=>1000, "convert"=>"USD"})
      return if response.blank?
      pricing = ::Pricing.where("start_time>? and end_time<=?", DateTime.now.beginning_of_hour, DateTime.now.end_of_hour+1.second).first
      if pricing.blank?
        pricing = ::Pricing.new(start_time: DateTime.now.beginning_of_hour+1.second, end_time: DateTime.now.end_of_hour+1.second)
      end
      data = pricing.data
      #we are converting it in to_datetime again so we can get beginninh of the minute
      data[time.to_datetime.strftime('%Q')] = response['quote']['USD'] rescue {}
      data = Hash[data.sort_by {|k, v| k.to_i }]
      pricing.update(data: data)
    end

    private
      def get(url, parameters)
        @response ||= HTTParty.get(
          url, 
          query: parameters.as_json, 
          headers: { 'X-CMC_PRO_API_KEY' => ENV['X-CMC_PRO_API_KEY'] }
        )
        @response.parsed_response['data'].select {|object| object['name']=='Bitcoin'}.first rescue {}
      end
  end
end