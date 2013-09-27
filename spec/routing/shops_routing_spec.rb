require "spec_helper"

describe ShopsController do
  describe "routing" do
    it "routes to current" do
      get("/shops/current").should route_to("shops#current")
    end
    it "routes to show" do
      get("/shops/1").should route_to("shops#show",id: "1")
    end
    it "routes to current_qr_upload" do
      put("/shops/current_qr_upload").should route_to("shops#current_qr_upload")
    end
    it "routes to generate_card" do
      put("/shops/generate_card").should route_to("shops#generate_card")
    end

  end
end


