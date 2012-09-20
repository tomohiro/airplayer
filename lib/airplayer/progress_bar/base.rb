require 'ruby-progressbar'

class ProgressBar
  class Base
    def total=(new_total)
      with_update { @bar.total = new_total }
    end
  end
end
