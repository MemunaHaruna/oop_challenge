module Response
  def json_error_response(message: "error", status: :unprocessable_entity, errors: "errors")
    render json: { message: message, errors: errors}, status: status
  end

  def json_response(message: 'Success', status: :ok, data: nil, show_children: true)
    if data.respond_to? :size
      return render json: data, meta: pagination_dict(data), message: message, status: status
    end
    render json: {message: message}, status: status
  end

end
