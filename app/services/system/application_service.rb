# frozen_string_literal: true

class System::ApplicationService
  def minimum(application_id)
    System::Application.new do |app|
      app.id = application_id
    end
  end
end
