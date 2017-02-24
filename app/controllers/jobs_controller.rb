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
      if params[:pending]
        @job.update(pending: true, worker_id: current_worker.id)
        format.html { redirect_to worker_path(current_worker), notice: "You've successfully claimed this job." }
        format.js { render 'create'}
      elsif params[:current_status]
        Job.set_current_job(@job.id, current_worker.id)
        format.js { render 'current' }
      elsif params[:completed]
        @job.update(completed: true)
        format.js { render 'complete' }
      end
    end
  end


private

  def job_params
    params.require(:job).permit(:title, :description, :pending, :current_status, :completed)
  end

end
