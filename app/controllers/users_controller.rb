class UsersController < ApplicationController
  before_action :verify_token, only: :mailchimp

  def index
    users = User.page(params[:page]).per(params[:per_page] || 10)

    # TO-DO: switch to ActiveModel::Serializer
    render json: {'users': users}, status: :ok
  end

  def show
    users = User.find_by(customer_id: params[:id])

    # TO-DO: switch to ActiveModel::Serializer
    render json: {'users': users}, status: :ok
  end

  def search
    users = FilterUsers.new(params).search

    users = users.page(params[:page]).per(params[:per_page] || 10)
    # TO-DO switch to ActiveModel::Serializer
    render json: {'users': users}, status: :ok
  end

  def create
    User.destroy_all
    BaseParser.new(file: create_params).call
    # TO-DO switch to ActiveModel::Serializer

    json_response(message: 'Successfully uploaded file. Processing in progress...')

    # TO-DO:
    # Fix ActiveJob error
    # export users
  rescue => error
    # TO-DO switch to ActiveModel::Serializer
    json_error_response(message: 'Error while processing file',
                        status: :unprocessable_entity, errors: error
                      )
  end

  def mailchimp
    ProcessMailchimpResponseJob.perform_later(request.raw_post)
  end

  private
    def create_params
      params.require(:users)
    end

    def verify_token
      MailchimpVerifier.new(request.headers).call
    end
end
