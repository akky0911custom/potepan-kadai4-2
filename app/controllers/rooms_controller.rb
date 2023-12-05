class RoomsController < ApplicationController
  before_action :authenticate_user, {except: [:top, :show, :search]}
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}

  def top
    @q = Room.ransack(params[:q])
    @rooms = @q.result(distinct: true)
  end

  def index
    @rooms = @current_user.rooms.all
  end

  def new
    @room = Room.new
  end

  def show
    @room = Room.find(params[:id])
  end

  def create
    @room = @current_user.rooms.create(room_params)
    if @room.save
      flash[:notice] = "施設を登録しました"
      redirect_to :rooms
    else
      flash[:notice] = "施設の登録に失敗しました"
      render "new"
    end
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      flash[:notice] = "施設を編集しました"
      redirect_to :rooms
    else
      flash[:notice] = "施設の編集に失敗しました"
      render "edit"
    end
  end

  def ensure_correct_user
    @room = Room.find(params[:id])
    if @room.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to :root
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to :rooms
  end

  def search
    @q = Room.ransack(params[:q])
    @rooms = @q.result(distinct: true)
  end

private
  def room_params
    params.require(:room).permit(:name,:image,:detail,:address,:charge,:user_id)
  end
end
