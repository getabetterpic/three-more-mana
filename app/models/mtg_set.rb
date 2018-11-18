class MtgSet < ApplicationRecord
  validates :name, :code, presence: true
  validates :code, uniqueness: { case_sensitive: false }

  API_ATTRS = %w(code name released_at set_type card_count parent_set_code block_code block).freeze

  def self.from_api(json)
    set = find_or_initialize_by(code: json['code'])
    set.update_attributes(json.slice(*API_ATTRS))
  end
end
