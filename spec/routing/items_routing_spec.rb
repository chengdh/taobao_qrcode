require "spec_helper"

describe ItemsController do
  describe "routing" do

    it "routes to #index" do
      get("/items").should route_to("items#index")
    end

    it "routes to #show" do
      get("/items/1").should route_to("items#show", :id => "1")
    end
    it "routes to #download_zip" do
      get("/items/download_zip").should route_to("items#download_zip")
    end
    it "routes to #download_qr" do
      get("/items/1/download_qr").should route_to("items#download_qr",:id => "1")
    end
    it "routes to #img_upload" do
      put("/items/1/img_upload").should route_to("items#img_upload",:id => "1")
    end
    it "routes to #picture_upload" do
      put("/items/1/picture_upload").should route_to("items#picture_upload",:id => "1")
    end
  end
end
