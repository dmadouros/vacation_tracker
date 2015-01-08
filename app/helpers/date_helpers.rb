module DateHelpers
  def self.concise_format(date)
    return '' if date.blank?

    date.to_s(:concise)
  end
end