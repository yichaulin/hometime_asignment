class ReservationsController < ApplicationController
  def create
    body = JSON.parse(request.body.read, symbolize_names: true)
    err = ReservationService.new(body).run()

    if err
      logger.error err
      render json: {error: err}, status: err.http_status
    else
      render plain: 'OK', status: 200
    end
  end
end