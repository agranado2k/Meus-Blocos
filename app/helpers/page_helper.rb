module PageHelper
  def format_date(d)
    I18n.l(d.to_date, :format => :long)
  end
end
