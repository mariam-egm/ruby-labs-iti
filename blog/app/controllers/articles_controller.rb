class ArticlesController < ApplicationController
  http_basic_authenticate_with name: "mariam", password: "secret", except: [:index, :show]
  def index
      @articles = Article.all
      @user = current_user.email

  end
  def show
    @article = Article.find(params[:id])
  end

  def new
      @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end
  
  def create
      # render plain: params[:article].inspect
      @article = Article.new(params.require(:article).permit(:title, :text)) 
      @article.save
      
      if @article.save
          redirect_to @article
        else
          render 'new'
        end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(params.require(:article).permit(:title, :text))
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy  
    redirect_to articles_path
  end
end
