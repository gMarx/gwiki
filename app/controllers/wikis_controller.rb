class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
  end

  def new
  end

  def edit
    # @wiki = Wiki.find(params[:id])
  end

  def create
  end

  def update
  end

  def destroy
  end
end
