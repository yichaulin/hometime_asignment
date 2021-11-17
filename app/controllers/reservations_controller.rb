class ReservationsController < ApplicationController
  def create
    err = ReservationService.new(request.body.read).run()

    if err
      logger.error err
      render json: {error: err}, status: err.http_status
    else
      render plain: 'OK', status: 200
    end
  end
end