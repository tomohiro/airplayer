require 'ruby-progressbar'

class ProgressBar
  class Base
    def total=(new_total)
      with_update { with_progressables(:total=, new_total) }
    end
  end
end
