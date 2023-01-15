class BookingsController < ApplicationController
  before_action :set_astro_id, only: [:new, :create]
  before_action :set_booking, only: [:show, :destroy, :update]

  def index
    @bookings = Booking.where("user_id = ?", current_user.id)
  end

  def show
    @astro = @booking.astro
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.astro = @astro
    @booking.user = current_user
    @booking.status = "Pending confirmation"
    if @booking.save
      redirect_to booking_path(@booking)
    else
      render :new
    end
  end

  def update
    @booking.status = "Pending confirmation"
    @booking.save!
    redirect_to booking_path(@booking)
  end

  def destroy
    @booking.destroy
    redirect_to astro_path(@booking.astro)
  end

  private

  def set_astro_id
    @astro = Astro.find(params[:astro_id])
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:check_in, :check_out, :status)
  end
end
