class ReservationsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}

  def index
    @reservations = Reservation.where(user_id: @current_user.id)
  end

  def new
    session.delete(:reservation)
    @room = Room.find(params[:id])
    @reservation = Reservation.new
  end

  def show
    @reservation = @current_user.reservations.find(params[:id])
  end

  def new_confirm
    @room = Room.find(params[:reservation][:room_id])
    @reservation = @room.reservations.create(reservation_param)
    @reservation.user = @current_user
    session[:reservation] = @reservation
    if @reservation.invalid?
      flash[:notice] = "入力内容にエラーがあります"
      render "new"
    end
  end
  
  def create
    Reservation.create!(session[:reservation])
    session.delete(:reservation)
    flash[:notice] = "予約完了しました"
    redirect_to :users_reservations
	end

  def edit
    session.delete(:reservation)
    @reservation = @current_user.reservations.find(params[:id])
  end

  def edit_confirm
    @reservation = @current_user.reservations.find(params[:id])
    updated_attributes = @reservation.attributes.merge(reservation_param.to_h)
    @reservation = Reservation.new(updated_attributes)
    session[:reservation] = @reservation
    if @reservation.invalid?
      flash[:notice] = "入力内容にエラーがあります"
      render "edit"
    end
  end

  def update
    @reservation = @current_user.reservations.find(params[:id])
    @reservation.update!(session[:reservation])
    session.delete(:reservation)
    flash[:notice] = "予約編集完了しました"
    redirect_to users_reservations_path
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to :users_reservations
  end

  def ensure_correct_user
    @reservation = Reservation.find(params[:id])
    if @reservation.user_id != @current_user.id
      flash[:notice] = "`権限がありません"
      redirect_to :root
    end
  end

private
  def reservation_param
    params.require(:reservation).permit(:room_id,:check_in_date,:check_out_date,:number_of_people)
  end
end
