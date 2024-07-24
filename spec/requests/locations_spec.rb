require 'rails_helper'

RSpec.describe "Locations", type: :request do
  describe "GET /update_coordinates" do
    it "returns http success" do
      get "/locations/update_coordinates"
      expect(response).to have_http_status(:success)
    end
  end

end
