# When generating an application, an abstract ApplicationRecord class will be created in app/models/application_record.rb.
# This is the base class for all models in an app

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
 
  def self.ransackable_associations(auth_object = nil)
    @ransackable_associations ||= reflect_on_all_associations.map { |a| a.name.to_s }
  end

  def self.ransackable_attributes(auth_object = nil)
    @ransackable_attributes ||= column_names + _ransackers.keys + _ransack_aliases.keys + attribute_aliases.keys     
  end
end
