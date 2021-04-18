class CategoriesController < ApplicationController
  before_action :require_login
  
  def show
    @category = Category.find(params[:id])
    render :category
  end
end