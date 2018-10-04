require 'rails_helper'

RSpec.describe UsersController do
  describe "#create" do

    it "creates a user" do
      expect do
        post :create, :params => { :user => { :email => "test", :password => "test", :password_confirmation => "test" } }
      end.to change {User.count}
    end

    it "creates a player" do
      expect do
        post :create, :params => { :user => { :email => "test", :password => "test", :password_confirmation => "test" } }
      end.to change {Player.count}
    end
  end
end
