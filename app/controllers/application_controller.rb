class ApplicationController < ActionController::API
  private

  def render_success
    render json: {
      result: 'success'
    }
  end
end
