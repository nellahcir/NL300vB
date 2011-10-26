module CheckoutsHelper
  
  def show_date(date)
    date.strftime("%d-%b-%Y %H:%M")
  end
  
end
