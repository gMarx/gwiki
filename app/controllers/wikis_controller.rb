class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
  end

  def new
    @wiki = Wiki.new
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def create
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.update_attributes( wiki_params )

    if @wiki.save
      flash[:notice] = 'Wiki was updated'
      redirect_to @wiki
    else
      flash.now[:alert] = 'There was an error saving the wiki. Please try again.'
      render :edit
    end
  end

  def destroy
  end

  private
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
