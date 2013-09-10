require "spec_helper"

describe ItemsController do
  describe "routing" do

    it "routes to #index" do
      get("/items").should route_to("items#index")
    end

    it "routes to #show" do
      get("/items/1").should route_to("items#show", :id => "1")
    end
  end
end
