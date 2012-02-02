require 'spec_helper'

describe PageController do

  describe "GET 'auth'" do
    it "returns http success" do
      get 'auth'
      response.should be_success
    end
  end

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
  end

  describe "GET 'blocos'" do
    it "returns http success" do
      get 'blocos'
      response.should be_success
    end
  end

  describe "GET 'bloco'" do
    it "returns http success" do
      get 'bloco'
      response.should be_success
    end
  end

  describe "GET 'friends'" do
    it "returns http success" do
      get 'friends'
      response.should be_success
    end
  end

  describe "GET 'maps'" do
    it "returns http success" do
      get 'maps'
      response.should be_success
    end
  end

  describe "GET 'schedule'" do
    it "returns http success" do
      get 'schedule'
      response.should be_success
    end
  end

end
