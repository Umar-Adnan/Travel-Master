class TripBookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip

  def create
    @booking = @trip.trip_bookings.build(booking_params)
    if @booking.save
      flash[:notice] = "Expense '#{@booking.title}' added to trip."
    else
      flash[:alert] = "Failed to add expense. Please check input values."
    end
    redirect_to trip_path(@trip)
  end

  def destroy
    @booking = @trip.trip_bookings.find(params[:id])
    @booking.destroy
    flash[:notice] = "Expense removed."
    redirect_to trip_path(@trip)
  end

  def update
    @booking = @trip.trip_bookings.find(params[:id])
    if @booking.update(booking_params)
      flash[:notice] = "Booking item updated."
    else
      flash[:alert] = "Failed to update item."
    end
    redirect_to trip_path(@trip)
  end

  private

  def set_trip
    @trip = current_user.trips.find(params[:trip_id])
  end

  def booking_params
    params.require(:trip_booking).permit(:item_type, :title, :unit_cost, :quantity, :booking_status, :date, :details)
  end
end
