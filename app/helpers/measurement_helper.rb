module MeasurementHelper
  def css_for_change(type, change)
    if type == "waist"
      change.positive? ? "worse" : "better"
    else
      change.positive? ? "better" : "worse"
    end
  end
end
