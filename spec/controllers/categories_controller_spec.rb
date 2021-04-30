require 'rails_helper.rb'

describe CategoriesController do
  describe "GET show" do
    context "user logged in" do
      before(:each) do
        login
      end

      it "sets category based on params" do
        category = Category.create(name: "test")
        get :show, params: { id: category.id }
        expect(assigns(:category)).to eq(Category.first)
      end
  
      it "renders category template" do
        category = Category.create(name: "test")
        get :show, params: { id: category.id }
        expect(response).to render_template(:category)
      end
    end

    context "no user logged in" do
      it_behaves_like "a page for logged in users only" do
        let(:action) do
          category = Category.create(name: "test")
          get :show, params: { id: category.id }
        end
      end
    end
  end
end