class CollaboratorsController < ApplicationController
  def create
    wiki = Wiki.find(params[:wiki_id])
    user = User.find(params[:user_id])
    collaborator = user.collaborators.build(wiki: wiki)

    if collaborator.save
      flash[:notice] = 'Collaborator Added.'
    else
      flash[:alert] = 'Failed to add Collaborator.'
    end

    redirect_to [wiki]
  end

  def destroy
    wiki = Wiki.find(params[:wiki_id])
    user = User.find(params[:user_id])
    collaborator = Collaborator.where(user_id: user.id, wiki_id: wiki.id).first
    # user.collaborators.find(wiki_id: wiki.id, user_id: user.id)

    if collaborator.destroy
      flash[:notice] = 'Collaborator removed.'
    else
      flash[:alert] = 'Failed to remove Collaborator.'
    end

    redirect_to [wiki]
  end
end
