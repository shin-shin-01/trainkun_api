class ApplicationController < ActionController::API
  def hello
    render json: { status: 'SUCCESS', data: 'Hello TrainBot' }, status: :ok
  end
end
