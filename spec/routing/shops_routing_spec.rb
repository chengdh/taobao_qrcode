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

  end
end


