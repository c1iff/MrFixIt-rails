require 'rails_helper'

describe Job do
  it { should belong_to :worker }
end

describe('set_current_job') do
  it('should set the current_job attribute to true') do
    worker = FactoryGirl.create(:worker)
    job = FactoryGirl.create(:job, worker_id: worker.id)
    Job.set_current_job(job.id, worker.id)
    expect(job.current_status).to eq false
  end
end
