class MicropostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def new
    @micropost = Micropost.new
  end
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      redirect_to micropost_path(@micropost), notice: "メッセージを投稿しました。"
    else
      render :new
    end
  end
  def index
    @microposts = Micropost.all.order(id: "DESC")
  end
  def show
    @micropost = Micropost.find(params[:id])
  end
  def edit
    @micropost = Micropost.find(params[:id])
    if @micropost.user != current_user
        redirect_to microposts_path, alert: "不正なアクセスです。"
    end
  end
  def update
    @micropost = Micropost.find(params[:id])
    if @micropost.update(micropost_params)
      redirect_to micropost_path(@micropost), notice: "メッセージを更新しました。"
    else
      render :edit
    end
  end
  def destroy
    micropost = Micropost.find(params[:id])
    micropost.destroy
    redirect_to user_path(micropost.user), notice: "メッセージを削除しました。"
  end

  private
  def micropost_params
    params.require(:micropost).permit(:title, :body, :image, :comment)
  end
end
