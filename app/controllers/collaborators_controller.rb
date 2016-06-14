class CollaboratorsController < ApplicationController
  def create
    wiki = Wiki.find(params[:wiki_id])
    collaborator = current_user.collaborators.build(wiki: wiki)

    if collaborator.save
      flash[:notice] = 'Collaborator Added.'
    else
      flash[:alert] = 'Failed to add Collaborator.'
    end

    redirect_to [wiki]
  end

  def destroy
    wiki = Wiki.find(params[:wiki_id])
    collaborator = current_user.collaborators.find(params[:id])

    if favorite.destroy
      flash[:notice] = 'Collaborator removed.'
    else
      flash[:alert] = 'Failed to remove Collaborator.'
    end

    redirect_to [wiki]
  end
end
