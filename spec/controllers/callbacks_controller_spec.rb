require 'rails_helper'

RSpec.describe CallbacksController, type: :controller do

  describe "GET #slack" do
    it "returns http success" do
      get :slack
      expect(response).to have_http_status(:success)
    end
  end

end
