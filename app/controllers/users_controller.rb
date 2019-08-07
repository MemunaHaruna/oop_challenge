class UsersController < ApplicationController
  before_action :verify_token, only: :mailchimp

  def index
    users = User.page(params[:page]).per(params[:per_page] || 10)
    json_response(data: users)
  end

  def show
    users = User.find_by(customer_id: params[:id])
    json_response(data: users)
  end

  def search
    users = FilterUsers.new(params).search

    users = users.page(params[:page]).per(params[:per_page] || 10)
    json_response(data: users)
  end

  def create
    process_request
    json_response(message: 'Successfully uploaded file. Processing in progress...')
  rescue => error
    json_error_response(message: 'Error while processing file',
                        status: :unprocessable_entity, errors: error
                      )
  end

  def mailchimp
    ProcessMailchimpResponseJob.perform_later(request.raw_post)
  end

  def report
    email = params.require(:email)
    ExportUsersService.call(email)
    json_response(message: 'Download in progress. Kindly check your email after a few minutes')
  rescue => error
    json_error_response(message: 'Error while processing request',
                        status: :unprocessable_entity, errors: error
                      )
  end

  private
    def create_params
      params.require(:users)
    end

    def verify_token
      MailchimpVerifier.new(request.headers).call
    end

    def process_request
      User.destroy_all
      file_type = FileValidator.call(create_params)
      if file_type.presence == FileValidator.type[file_type]
        BaseParser.new(file: create_params, file_parser: XlsParser.new).call
      end
      BaseParser.new(file: create_params).call
    end
end
