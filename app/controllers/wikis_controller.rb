class WikisController < ApplicationController

  before_action :authenticate_user!, except: [:index]

  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
  end

  def edit
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
  end

  def create
    @wiki = Wiki.new( wiki_params )
    @wiki.user = current_user
    authorize @wiki

    if @wiki.save
      flash[:notice] = 'Wiki was saved'
      redirect_to @wiki
    else
      flash.now[:alert] = 'There was an error saving the wiki. Please try again.'
      render :new
    end

  end

  def update
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki

    if @wiki.update_attributes( wiki_params )
      flash[:notice] = 'Wiki successfully updated.'
      redirect_to @wiki
    else
      flash.now[:alert] = 'There was an error saving the wiki. Please try again.'
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "#{@wiki.title} was successfully deleted."
      redirect_to action: :index
    else
      flash[:alert] = "#{@wiki.title} could not be deleted."
      render :show
    end
  end

  private

  # params = { controller: 'WikiController', action: 'update', id: 123, wiki: { title: 'asdf', body: 'qwerqwerw'} }
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
