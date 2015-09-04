class Api::V1::JobsController < ApplicationController
  before_filter :authorize_response
  before_filter :authorize_user, only: [:download]
  before_filter :find_user, only: [:create, :download]
  ALLOWED_IMAGE_OPERATIONS = [:resize, :spread, :sketch]
  def create
    job = @user.jobs.create(job_params)
    job.process(job_params[:actions])
    render json: if job.valid?
                   { data: job.slice('id', 'destination_url', 'actions'),
                     message: 'Job created successfully',
                     status: 201 }
                 else
                   { errors: { message: 'Cannot process the request' },
                     status: 403 }
                 end
  end

  def download
    file_name = File.basename(Job.find_by_id(params[:id]).destination_url)
    if params[:file] == file_name
      send_file("#{Rails.root}/public/jobs/#{params[:id]}/#{file_name}",
                disposition: 'attachment')
    else
      render json: { errors: { message: 'Cannot process the request' },
                     status: 403 }
    end
  end

  private

  def job_params
    params.permit(:source_url, :original_media, :notification_url, actions:
      ALLOWED_IMAGE_OPERATIONS)
  end

  def find_user
    @user = User.find_by_api_key(request.headers['API-KEY'])
  end
end
