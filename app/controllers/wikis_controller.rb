class WikisController < ApplicationController

  before_action :authenticate_user!, except: [:index]

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def create
    @wiki = Wiki.create( wiki_params )
    @wiki.user = current_user

    if @wiki.save
      flash[:notice] = 'Wiki was saved'
      redirect_to @wiki
    else
      flash.now[:alert] = 'There was an error saving the wiki. Please try again.'
      render :new
    end

  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
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
    @wiki = Wiki.find(params[:id])
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
