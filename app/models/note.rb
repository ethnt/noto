class Note
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title,     type: String, default: 'Untitled'
  field :text,      type: String
  field :html,      type: String
  field :permalink, type: String

  before_validation :html!, :permalink!

  validates :title, presence: true

  belongs_to :user

  protected

  def html!
    markdown = Rails.configuration.markdown

    self.html = markdown.render(self.text)
  end

  def permalink!
    unless self.permalink
      str = self.title

      str = str.gsub(/[^0-9a-z ]/i, '')
      str = str.gsub(/ /, '-')
      str = str.downcase

      count = Note.where(
        user_id: self.user_id,
        permalink: /#{Regexp.quote(str)}/
      ).count

      if count > 1
        str ="#{str}-#{count + 1}"
      end

      self.permalink = str
    end
  end
end
