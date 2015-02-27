class WikisController < ApplicationController
  def index
    @wikis = policy_scope(Wiki)
    # authorize @wikis
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = current_user.wikis.build(params.require(:wiki).permit(:title, :body, :private))
    authorize @wiki
    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    @users = User.where.not(id: current_user.id)
  end

  def update
   @wiki = Wiki.find(params[:id])
   authorize @wiki
   if @wiki.update_attributes(params.require(:wiki).permit(:title, :body, :private))
     flash[:notice] = "Wiki was updated."
     redirect_to @wiki
   else
     flash[:error] = "There was an error saving the wiki. Please try again."
     render :edit
   end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    title = @wiki.title
    authorize @wiki
    if @wiki.destroy
      redirect_to root_path, notice: "\"#{title}\" was deleted successfully."
    else
      flash[:error] = "There was an error deleting the wiki."
      render :show
    end
  end

end
