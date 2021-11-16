class ReservationsController < ApplicationController
    def create
        body = request.parameters
        service = ReservationService.new(body)
        res, err = service.run()

        if err
            render json: {error: err}, status: 400
        else
            render json: {res: res}, status: 200
        end

    end
end