require 'rails_helper'

RSpec.describe UsersController do
  describe "#create" do

    it "creates a user" do
      expect do
        post :create, :params => { :signup => { :email => "test", :password => "test", :password_confirmation => "test" } }
      end.to change {User.count}
    end

    it "creates a player" do
      expect do
        post :create, :params => { :signup => { :email => "test", :password => "test", :password_confirmation => "test" } }
      end.to change {Player.count}
    end

    it 'render success true' do
      post :create, :params => { :signup => { :email => "test", :password => "test", :password_confirmation => "test" } }
      json = JSON.parse(response.body)
      expect(json['success']).to eq(true)
    end

    context 'user already created' do
      before do
        post :create, :params => { :signup => { :email => "test", :password => "test", :password_confirmation => "test" } }
      end

      it 'returns with 422' do
        post :create, :params => { :signup => { :email => "test", :password => "test", :password_confirmation => "test" } }
        expect(response).to have_http_status(422)
      end

      it 'renders success false' do
        post :create, :params => { :signup => { :email => "test", :password => "test", :password_confirmation => "test" } }
        json = JSON.parse(response.body)
        expect(json['error']).to eq(UserResult::ERROR_TYPES[:duplicate])
      end
    end
  end
end
