class CssColorValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/i || Color::CSS[value]
      record.errors[attribute] << (options[:message] || 'is not a valid CSS color')
    end
  end
end
