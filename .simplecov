SimpleCov.start 'rails' do
  enable_coverage :branch
  primary_coverage :branch

  add_group "Models", "app/models"
  add_group "Controllers", "app/controllers"
end
