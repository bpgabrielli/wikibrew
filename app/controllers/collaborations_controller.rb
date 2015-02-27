class CollaborationsController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    @wiki = Wiki.find(params[:wiki_id])
    @collaboration_new = Collaboration.new(user: @user, wiki: @wiki)
    if @collaboration_new.save
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:error] = "Error adding user. Please try again."
      render :back
    end
  end

  def destroy
    @collaboration = Collaboration.find(params[:collaboration_id])
    if @collaboration.destroy
      redirect_to edit_wiki_path
    else
      flash[:error] = "Error removing user. Please try again."
      render :back
    end
  end

end
