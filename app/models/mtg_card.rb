class MtgCard < ApplicationRecord
  validates :name, presence: true
  validates :uuid, presence: true, uniqueness: { case_sensitive: false }

  belongs_to :set, class_name: 'MtgSet', foreign_key: :set_code, primary_key: :code

  API_ATTRS = %w(name layout hires_image image_uris mana_cost cmc type_line oracle_text power toughness colors
    color_identity legalities rarity card_faces).freeze

  scope :standard_legal, -> { where("legalities->>'standard' = 'legal'") }
  scope :modern_legal, -> { where("legalities->>'modern' = 'legal'") }
  scope :legacy_legal, -> { where("legalities->>'legacy' = 'legal'") }
  scope :commander_legal, -> { where("legalities->>'commander' = 'legal'") }
  scope :not_land, -> { where.not('type_line LIKE ?', '%Land%') }

  def self.from_api(json)
    card = find_or_initialize_by(uuid: json['id'])
    card.set_code = json['set']
    card.update_attributes(json.slice(*API_ATTRS))
  end

  def standard_legal?
    legalities['standard'] == 'legal'
  end

  def modern_legal?
    legalities['modern'] == 'legal'
  end

  def legacy_legal?
    legalities['legacy'] == 'legal'
  end

  def commander_legal?
    legalities['commander'] == 'legal'
  end

  def land?
    type_line =~ /Land/
  end
end
