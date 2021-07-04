RSpec.describe 'Rails.application', type: :routing do
  xit "fails if application has unused actions" do
    expect(Rails.application).to have_no_unused_actions
  end

  # it "fails if application has unused routes" do
  #  expect(Rails.application).to have_no_unused_routes
  # end
end
