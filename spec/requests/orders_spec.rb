require 'rails_helper'

RSpec.describe "Orders", type: :request do
  describe "GET json" do

    it "for kitchen" do
      get '/orders/export.json'
      expect(response).to have_http_status(200)
    end
  end
end
