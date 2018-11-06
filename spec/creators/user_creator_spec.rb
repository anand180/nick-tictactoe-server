require 'rails_helper'

RSpec.describe UserCreator do
  describe ".create" do
    it "creates a user" do
      expect do
        UserCreator.create_user
      end.to change {User.count}
    end

    it "creates a player" do
      expect do
        UserCreator.create_user
      end.to change {Player.count}
    end
  end
end
