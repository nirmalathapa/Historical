class MeasurementForm
  include ActiveModel::Model

  attr_accessor :date, :user, :tracker

  def initialize(user, tracker, attributes = {})
    @user = user
    @tracker = tracker

    measurement_fields.each do |field|
      define_singleton_method(field) do
        instance_variable_get("@#{field}".to_sym) || fetch_value(field)
      end

      define_singleton_method("#{field}=") do |value|
        instance_variable_set("@#{field}", value)
      end
    end

    super(attributes)
  end

  def measurement_fields
    @measurement_fields ||= measurement_types.all.map(&:name)
  end

  def date
    @date ||= Date.today
  end

  def save
    measurement_fields.each do |field|
      if (value = public_send(field)).present?
        type = measurement_types.find_by(name: field)
        Measurement
          .where(user: user, measurement_date: date, measurement_type: type)
          .first_or_create
          .update_attributes!(value: value)
      end
    end
  end

  private

  def fetch_value(field)
    type = measurement_types.find_by(name: field)
    Measurement
      .find_by(user: user, measurement_date: date, measurement_type: type)
      .try(:value)
  end

  def measurement_types
    tracker.measurement_types
  end
end
