module MeasurementHelper
  def css_for_change(type, change)
    if %q(waist bodyfat).include? type
      change.positive? ? "worse" : "better"
    else
      change.positive? ? "better" : "worse"
    end
  end
end
