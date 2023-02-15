class BookingsController < ApplicationController
  before_action :set_astro_id, only: %i[new create]
  before_action :set_booking, only: %i[destroy]

  # all bookings made by the current user ...
  def index
    @bookings = policy_scope(Booking)
  end

  def new
    @booking = Booking.new
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.astro = @astro
    @booking.user = current_user
    authorize @booking
    @booking.status = "Pending"
    if @booking.save!
      redirect_to bookings_path, notice: "Your bookings was created. Waiting for host confirmation ..."
    else
      render :new, notice: "Booking unavailable. Please, check the dates."
    end
  end

  def destroy
    authorize @booking
    @booking.destroy
    redirect_to root_path
  end

  def hosted_astros
    @bookings = current_user.bookings_as_owner
    authorize @bookings
  end

  def confirm
    booking = Booking.find(params[:id])
    authorize booking
    booking.confirm!
    redirect_to hosted_astros_bookings_path, notice: "Request was confirmed!"
  end

  def reject
    booking = Booking.find(params[:id])
    authorize booking
    booking.reject!
    redirect_to hosted_astros_bookings_path, notice: "Request was rejected!"
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
