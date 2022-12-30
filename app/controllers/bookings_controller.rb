class BookingsController < ApplicationController
  before_action :set_astro_id, only: [:new, :create]

  def index
    @bookings = Booking.all
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.astro = @astro
    @booking.user = current_user
    @booking.status = "Pending."

    if @booking.save
      redirect_to astro_bookings_path, notice: "Booking request was succesfully created! Check its status!"
    else
      render :new, notice: "Unfortunately, it's not possible to proceed with your request."
    end
  end

  private

  def set_astro_id
    @astro = Astro.find(params[:astro_id])
  end

  def booking_params
    params.require(:booking).permit(:check_in, :check_out, :status)
  end
end
