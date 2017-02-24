class JobsController < ApplicationController
  respond_to :html, :js

  def index
    @jobs = Job.all
  end

  def new
   @job = Job.new
   render :new
  end

  def show
    @job = Job.find(params[:id])
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to jobs_path
    else
      render :new
    end
  end

  def update
    @job = Job.find(params[:id])
    respond_to do |format|
      binding.pry
      if params[:pending]
        @job.update(pending: true, worker_id: current_worker.id)
        format.html { redirect_to worker_path(current_worker), notice: "You've successfully claimed this job." }
        format.js { render 'create'}
      elsif params[:current_status]
        Job.set_current_job(@job.id, current_worker.id)
        format.js { render 'current' }
      elsif parmas[:completed]
        @job.update(completed: true)
        format.js { render 'complete' }
      end
    end
  end

    # if params[:pending]
    #   @job.update(pending: true, worker_id: current_worker.id)

    # if current_worker
    #   job = params[:job]
    #   if job && job[:current_status] == "1"
    #     Job.set_current_job(@job.id, current_worker.id)
    #     respond_to do |format|
    #       format.html {redirect_to worker_path(current_worker)}
    #       format.js {render 'current'}
    #     end
    #   elsif job && job[:current_status] == "0"
    #     job.update(current_status: false)
    #     respond_to do |format|
    #       format.html {redirect_to worker_path(current_worker)}
    #       format.js {render 'not_current'}
    #     end
    #   else
    #     if @job.update(pending: true, worker_id: current_worker.id)
    #       respond_to do |format|
    #         format.html {redirect_to worker_path(current_worker)}
    #         format.js {render 'create'}
    #         flash[:notice] = "You've successfully claimed this job."
    #       end
    #     else
    #       render :show
    #       flash[:notice] = "Something went wrong!"
    #     end
    #   end
    # else
    #   # We need to streamline this process better in the future! - Mr. Fix-It.
    #   flash[:notice] = 'You must have a worker account to claim a job. Register for one using the link in the navbar above.'
    #   redirect_to job_path(@job)
    # end

private

  def job_params
    params.require(:job).permit(:title, :description, :pending, :current_status, :completed)
  end

end
