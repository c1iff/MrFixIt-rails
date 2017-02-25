require 'rails_helper'

describe "the add a job process" do
  it "adds a job" do
    worker = FactoryGirl.create(:worker)
    job = FactoryGirl.create(:job)
    visit '/'
    click_on 'Log In as Worker'
    fill_in 'Email', :with => 'worker@epicodus.com'
    fill_in 'Password', :with => 'testtest'
    click_on 'Log in'
    click_on 'Add Your Job'
    fill_in 'Title', :with => 'This is a test job.'
    fill_in 'Description', :with => 'This is a test description.'
    click_on 'Create Job'
    expect(page).to have_content "This is a test job."
  end
end
