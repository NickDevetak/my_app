class WelcomeController < ApplicationController

  require 'net/http'

  protect_from_forgery

  def index
    @errors = {}
  end

  def test
    @person = Person.new
    @person.firstname = params[:firstname]
    @person.lastname = params[:lastname]
    @person.postcode = params[:postcode]

    if @person.valid?
      search_postcode = @person.postcode.delete(' ')

      url = "http://api.postcodes.io/postcodes/#{search_postcode}"

      resp = Net::HTTP.get_response(URI.parse(url))
      # data = JSON.parse(resp.body)
      # puts "Eastings: #{data["result"]["eastings"]}"
      if (resp.code != '200') then
        @errors = { }
        @errors[:postcode] = 'Invalid postcode'
        render "index"
      end
    else
      @errors = @person.errors.to_hash
      render "index"
    end

  end

end
