class Job < ActiveRecord::Base
  validates :title, :presence => true

  def self.set_current_job(job_id, worker_id)
    jobs = Job.where(:worker_id, worker_id)
    jobs.each do |job|
      if job[:current_status] == true
        job.update(:current_status false)
      end
    end
    current_job = Job.where(:id job_id)
    current_job.update(:current_status true)
  end
end
