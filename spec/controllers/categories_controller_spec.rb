require 'rails_helper.rb'

describe CategoriesController do
  describe "GET show" do

    it "sets category based on params" do
      session[:user_id] = Fabricate(:user).id
      category = Category.create(name: "test")
      get :show, params: { id: category.id }
      expect(assigns(:category)).to eq(Category.first)
    end

    it "renders category template" do
      session[:user_id] = Fabricate(:user).id
      category = Category.create(name: "test")
      get :show, params: { id: category.id }
      expect(response).to render_template(:category)
    end
  end
end