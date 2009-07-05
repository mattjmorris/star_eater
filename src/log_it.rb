##
# Allows logging to be less cluttersome.
# LogIt needs to be 'extended' so that log method can be at class level
##
module LogIt
  def log(methods_and_vars)

    methods_and_vars.each do |method, vars|

      original = "original #{method}"

      alias_method original, method

      define_method(method) do |*args|
        send original, *args
        log_str = ""
        # If the object has an @name, use that to identify, else use the class name
        log_str += @name ? "#{@name}" : "#{self.class}"
        log_str += " has set "
        vars.each do |var|
          var_name = "@#{var}"
          log_str += "#{var_name} to #{eval(var_name)} "
        end
        notify(log_str)
      end

    end

  end
end