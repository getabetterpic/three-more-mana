module ResourceIds
  extend ActiveSupport::Concern

  PREFIX = {
    'Deck' => 'DEK'
  }.freeze

  included { before_validation :create_resource_id, on: :create }

  def create_resource_id
    return true if resource_id.present?
    new_id = nil
    prefix = PREFIX[self.class.base_class.to_s]
    raise ArgumentError, "No prefix specified for class #{self.class.base_class}" unless prefix
    until new_id.present? && self.class.base_class.find_by(resource_id: new_id).nil?
      new_id = prefix + SecureRandom.uuid.delete('-')
    end

    self.resource_id = new_id
  end
end
