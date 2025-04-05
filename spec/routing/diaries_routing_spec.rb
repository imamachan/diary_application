require "rails_helper"

RSpec.describe DiariesController, type: :routing do
  it "routes /diaries to diaries#index" do
    expect(get: "/diaries").to route_to("diaries#index")
  end
end
