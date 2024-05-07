class ApiService
  def initialize
    @conn = Faraday.new(url: "https://api.themoviedb.org/3") do |faraday|
      faraday.headers["Authorization"] = "Bearer #{Rails.application.credentials.themoviedb[:bearer_token]}"
      # require 'pry'; binding.pry
    end
  end
  
  def get(path, params = {})
    response = @conn.get(path, params)
    handle_response(response)
  end

   private

  def handle_response(response)
    if response.success?
      JSON.parse(response.body, symbolize_names: true)
    else
      raise "Error: #{response.status}"
    end
  end
end