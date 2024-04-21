# When generating an application, an abstract ApplicationRecord class will be created in app/models/application_record.rb.
# This is the base class for all models in an app

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
