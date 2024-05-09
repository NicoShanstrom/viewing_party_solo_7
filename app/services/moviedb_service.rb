class MoviedbService

  def initialize
    @connect = Faraday.new(url: "https://api.themoviedb.org") do |conn|
      conn.request :authorization, 'Bearer', Rails.application.credentials.themoviedb[:bearer_token]
    end
    # require 'pry'; binding.pry
  end
  
  def get(path, params = {})
    response = @connect.get(path, params)
    handle_response(response)
    # require 'pry'; binding.pry
  rescue Faraday::Error => e
    raise "Faraday Error: #{e.message}"
  end

  private
  
  def handle_response(response)
    return {} unless response&.success?
    
    content_type = response.headers["Content-Type"]
    if content_type.include?("application/json")
      JSON.parse(response.body, symbolize_names: true)
    else
      raise "Unexpected content type: #{content_type}"
    end
  end
end
# private

  # def handle_response(response)
  #   if response.success?
  #     JSON.parse(response.body, symbolize_names: true)
  #   else
  #     raise "Error: #{response.status}"
  #   end
  # end