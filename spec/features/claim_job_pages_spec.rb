require 'rails_helper'

describe "the claim a job process" do
  it "claims a job and give ajax response" do
    worker = FactoryGirl.create(:worker)
    job = FactoryGirl.create(:job)
    visit '/'
    click_on 'Log In as Worker'
    fill_in 'Email', :with => 'worker@epicodus.com'
    fill_in 'Password', :with => 'testtest'
    click_on 'Log in'
    click_on 'See All Jobs'
    click_on 'This is a job.'
    click_on 'click here to claim it now'
    expect(page).to have_content "You've successfully claimed this job."
  end
end
