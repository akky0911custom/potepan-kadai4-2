class ReservationsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}

  def index
    @reservations = Reservation.where(user_id: @current_user.id)
  end

  def new
    @room = Room.find(params[:id])
    @reservation = Reservation.new
  end

  def show
    @reservation = @current_user.reservations.find(params[:id])
  end

  def create
    @room = Room.find(params[:reservation][:room_id])
    @reservation = @room.reservations.create(reservation_param)
    @reservation.user = @current_user
    if @reservation.save
      flash[:notice] = "予約完了しました"
      redirect_to :users_reservations
    else
      flash[:notice] = "予約に失敗しました"
      render "new"
    end
  end

  def edit
    @reservation = @current_user.reservations.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(reservation_param)
      flash[:notice] = "予約編集完了しました"
      redirect_to :users_reservations
    else
      flash[:notice] = "予約編集失敗しました"
      render "edit"
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to :users_reservations
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to :root
    end
  end

private
  def reservation_param
    params.require(:reservation).permit(:room_id,:check_in_date,:check_out_date,:number_of_people)
  end
end
