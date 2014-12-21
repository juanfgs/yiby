require 'net/http'
require 'uri'
require 'json'

class Service
  attr_reader :api_url, :params
  
  def initialize (url)
    @api_url = URI(url)
    @params = []
  end

  def run
    unless api_url.respond_to? :request_uri
      raise ArgumentError, 'Invalid URI'
    end

    res = Net::HTTP.get_response(api_url)

    if res.is_a?(Net::HTTPSuccess)
      JSON.parse res.body 
    else
      {:error => res.message}
    end
  end
  
  def add_param (item)
    @params  << item
    api_url.query = URI.encode_www_form @params
  end

  def reset_query()
    @params = []
    api_url.query = nil
  end

  
  
end
