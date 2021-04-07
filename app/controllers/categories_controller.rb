class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    render 'ui/genre'
  end
end