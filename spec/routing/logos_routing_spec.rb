require "spec_helper"

describe LogosController do
  describe "routing" do

    it "routes to #index" do
      get("/logos").should route_to("logos#index")
    end

    it "routes to #new" do
      get("/logos/new").should route_to("logos#new")
    end

    it "routes to #show" do
      get("/logos/1").should route_to("logos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/logos/1/edit").should route_to("logos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/logos").should route_to("logos#create")
    end

    it "routes to #update" do
      put("/logos/1").should route_to("logos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/logos/1").should route_to("logos#destroy", :id => "1")
    end

  end
end
