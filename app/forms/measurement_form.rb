class MeasurementForm
  include ActiveModel::Model

  attr_accessor :date, :user

  def self.measurement_fields
    @measurement_fields ||= MeasurementType.all.map(&:name)
  end

  self.measurement_fields.each do |field|
    attr_writer field

    define_method field do
      instance_variable_get("@#{field}".to_sym) || fetch_value(field)
    end
  end

  def date
    @date ||= Date.today
  end

  def save
    # byebug
    self.class.measurement_fields.each do |field|
      if (value = public_send(field)).present?
        type = MeasurementType.find_by(name: field)
        Measurement
          .where(user: user, measurement_date: date, measurement_type: type)
          .first_or_create
          .update_attributes!(value: value)
      end
    end
  end

  def fetch_value(field)
    type = MeasurementType.find_by(name: field)
    Measurement
      .find_by(user: user, measurement_date: date, measurement_type: type)
      .try(:value)
  end
end
