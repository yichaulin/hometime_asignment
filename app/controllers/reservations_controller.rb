class ReservationsController < ApplicationController
  def create
    begin
      err = ReservationService.new(request.parameters).run()
    rescue => e
      err = e
    end

    logger.error err.to_s if err

    if err.is_a?(ActiveRecord::RecordInvalid)
      http_status = 400
      res = {error: err}
    elsif err
      http_status = 500
      res = {error: err}
    else
      http_status = 200
      res = {res: "OK"}
    end

    render json: res, status: http_status
  end
end