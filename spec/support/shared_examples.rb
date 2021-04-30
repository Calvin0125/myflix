require 'rails_helper.rb'

shared_examples "a page for logged in users only" do
  it "redirects to root path" do
    action
    expect(response).to redirect_to root_path 
  end
end