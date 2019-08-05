module Response
  def json_error_response(message: "error", status: :unprocessable_entity, errors: "errors")
    render json: { message: message, errors: errors}, status: status
  end

  def json_response(message: 'Success', status: :ok)
    render json: { message: message}, status: status
  end
end
