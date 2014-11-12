class Note
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title,     type: String, default: 'Untitled'
  field :text,      type: String
  field :permalink, type: String

  before_validation :permalink!

  validates :title, presence: true

  belongs_to :user

  def permalink!
    unless self.permalink
      str = self.title

      str = str.gsub(/[^0-9a-z ]/i, '')
      str = str.gsub(/ /, '-')
      str = str.downcase

      self.permalink = str
    end
  end
end
