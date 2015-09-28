module Attribute

  def attribute(*names)
    names.each do |name|
      define_method(name) do |value = nil|
        return instance_variable_get("@#{name}") unless value
        instance_variable_set("@#{name}", value)
      end
    end
  end

end
