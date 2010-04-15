class TimeEvent < ActiveRecord::Base
  
  before_save :parse_dates
  
  def to_label
    display_english
  end
  def display_english
    str = ''
    if begin_type == 'day'
      str = "#{date_start_year}/#{date_start_month}/#{date_start_day}"
      if date_end_year != 0
        str += " - #{date_end_year}/#{date_end_month}/#{date_end_day}"
      end
    elsif begin_type == 'year'
      str = "#{date_start_year-date_start_minus_delta}"
      if date_start_plus_delta > 0 and date_end_year == 0
        str += " - #{date_start_year+date_start_plus_delta}"
      end
      if date_end_year != 0 and date_end_year != nil
        str += " - #{date_end_year+date_end_plus_delta}"
      end
    else
      str = case date_start_century
        when 100 then '2nd'
        when 200 then '3rd'
        when 300 then '4th'
        when 400 then '5th'
        when 500 then '6th'
        when 600 then '7th'
        when 700 then '8th'
        when 800 then '9th'
        when 900 then '10th'
        when 1000 then '11th'
        when 1100 then '12th'
        when 1200 then '13th'
        when 1300 then '14th'
        when 1400 then '15th'
        when 1500 then '16th'
        when 1600 then '17th'
        when 1700 then '18th'
        when 1800 then '19th'
        when 1900 then '20th'
        when 2000 then '21st'
      end
      str = "#{str} #{begin_encoding_type}"
      if date_start_century_secondary != nil and date_end_century == nil
        str += " - #{date_start_century_secondary}  #{begin_encoding_type_secondary}"
      end
      if date_end_century != nil
        cent = case date_end_century
          when 100 then '2nd'
          when 200 then '3rd'
          when 300 then '4th'
          when 400 then '5th'
          when 500 then '6th'
          when 600 then '7th'
          when 700 then '8th'
          when 800 then '9th'
          when 900 then '10th'
          when 1000 then '11th'
          when 1100 then '12th'
          when 1200 then '13th'
          when 1300 then '14th'
          when 1400 then '15th'
          when 1500 then '16th'
          when 1600 then '17th'
          when 1700 then '18th'
          when 1800 then '19th'
          when 1900 then '20th'
          when 2000 then '21st'
        end
        str2 = " - #{cent} #{finish_encoding_type}"
        if date_end_century_secondary != nil
          cent = case date_end_century_secondary
            when 100 then '2nd'
            when 200 then '3rd'
            when 300 then '4th'
            when 400 then '5th'
            when 500 then '6th'
            when 600 then '7th'
            when 700 then '8th'
            when 800 then '9th'
            when 900 then '10th'
            when 1000 then '11th'
            when 1100 then '12th'
            when 1200 then '13th'
            when 1300 then '14th'
            when 1400 then '15th'
            when 1500 then '16th'
            when 1600 then '17th'
            when 1700 then '18th'
            when 1800 then '19th'
            when 1900 then '20th'
            when 2000 then '21st'
          end
          str2 = " - #{cent} #{finish_encoding_type_secondary}"
        end
        str += str2
      end
    end
    str
  end
  
  def parse_dates
    # debugger
    if self.begin_date_center != nil
      a = self.begin_date_center.split('-')
      if a.size > 0
        self.date_start_year = a[0].to_i
      end
      if a.size > 1
        self.date_start_month = a[1].to_i
      end
      if a.size > 2
        self.date_start_day = a[2].to_i
      end
    end
    if self.finish_date_center != nil
      a = self.finish_date_center.split('-')
      if a.size > 0
        self.date_end_year = a[0].to_i
      end
      if a.size > 1
        self.date_end_month = a[1].to_i
      end
      if a.size > 2
        self.date_end_day = a[2].to_i
      end
    end
    self.date_start_plus_delta = 0
    self.date_start_minus_delta = 0
    if self.begin_type != 'century'   # need to add circa for "by year"
      if self.begin_date_start != nil
        a = self.begin_date_start.split('-')
        if a.size > 0
          start = a[0].to_i
          self.date_start_minus_delta = self.date_start_year - start
        end
      end
      if self.begin_date_end != nil
        a = self.begin_date_end.split('-')
        if a.size > 0
          finish = a[0].to_i
          self.date_start_plus_delta = finish - self.date_start_year
        end
      end
      if self.finish_date_start != nil
        a = self.finish_date_start.split('-')
        if a.size > 0
          start = a[0].to_i
          self.date_end_minus_delta = self.date_end_year - start
        end
      end
      if self.finish_date_end != nil
        a = self.finish_date_end.split('-')
        if a.size > 0
          finish = a[0].to_i
          self.date_end_plus_delta = finish - self.date_end_year
        end
      end
    else
      if self.begin_date_start != nil
        self.date_start_year = case self.begin_encoding_type
          when 'openLeft' then self.date_start_year
          when 'turnCent' then self.date_start_year
          when 'circa' then self.date_start_year
          when 'Century' then self.date_start_year
          when '1st third' then self.date_start_year + 16
          when '2nd third' then self.date_start_year + 50
          when '3rd third' then self.date_start_year + 83
          when '1st quarter' then self.date_start_year + 12
          when '2nd quarter' then self.date_start_year + 37
          when '3rd quarter' then self.date_start_year + 62
          when '4th quarter' then self.date_start_year + 87
          when '1st half' then self.date_start_year+25
          when '2nd half' then self.date_start_year+75
          when 'beginCent' then self.date_start_year+12
          when 'midCent' then self.date_start_year + 50
          when 'precise' then self.date_start_year
          when 'endCent' then self.date_start_year + 87
          when 'openRight' then self.date_start_year
        end
        self.date_start_minus_delta = case self.begin_encoding_type
          when 'openLeft' then 2000
          when 'turnCent' then 10
          when 'circa' then 5
          when 'Century' then 0
          when '1st third' then 16
          when '2nd third' then 16
          when '3rd third' then 16
          when '1st quarter' then 12
          when '2nd quarter' then 12
          when '3rd quarter' then 12
          when '4th quarter' then 12
          when '1st half' then 25
          when '2nd half' then 25
          when 'beginCent' then 12
          when 'midCent' then 17
          when 'precise' then 0
          when 'endCent' then 12
          when 'openRight' then 0
        end
        self.date_start_plus_delta = case self.begin_encoding_type
          when 'openLeft' then 0
          when 'turnCent' then 10
          when 'circa' then 5
          when 'Century' then 99
          when '1st third' then 16
          when '2nd third' then 16
          when '3rd third' then 16
          when '1st quarter' then 12
          when '2nd quarter' then 12
          when '3rd quarter' then 12
          when '4th quarter' then 12
          when '1st half' then 25
          when '2nd half' then 25
          when 'beginCent' then 12
          when 'midCent' then 16
          when 'precise' then 0
          when 'endCent' then 12
          when 'openRight' then 2000
        end
        if self.date_start_century_secondary != nil  # add in plus delta for right bounds
          self.date_start_year_secondary = case self.begin_encoding_type_secondary
            when 'openLeft' then self.date_start_year_secondary
            when 'turnCent' then self.date_start_year_secondary
            when 'circa' then self.date_start_year_secondary
            when 'Century' then self.date_start_year_secondary
            when '1st third' then self.date_start_year_secondary + 16
            when '2nd third' then self.date_start_year_secondary + 50
            when '3rd third' then self.date_start_year_secondary + 83
            when '1st quarter' then self.date_start_year_secondary + 12
            when '2nd quarter' then self.date_start_year_secondary + 37
            when '3rd quarter' then self.date_start_year_secondary + 62
            when '4th quarter' then self.date_start_year_secondary + 87
            when '1st half' then self.date_start_year_secondary+25
            when '2nd half' then self.date_start_year_secondary+75
            when 'beginCent' then self.date_start_year_secondary+12
            when 'midCent' then self.date_start_year_secondary + 50
            when 'precise' then self.date_start_year_secondary
            when 'endCent' then self.date_start_year_secondary + 87
            when 'openRight' then self.date_start_year_secondary
          end
          self.date_start_plus_delta = case self.begin_encoding_type_secondary
            when 'openLeft' then self.date_start_year_secondary - self.date_start_year
            when 'turnCent' then self.date_start_year_secondary - self.date_start_year + 10
            when 'circa' then self.date_start_year_secondary - self.date_start_year + 5
            when 'Century' then self.date_start_year_secondary - self.date_start_year + 99
            when '1st third' then self.date_start_year_secondary - self.date_start_year + 16
            when '2nd third' then self.date_start_year_secondary - self.date_start_year + 16
            when '3rd third' then self.date_start_year_secondary - self.date_start_year + 16
            when '1st quarter' then self.date_start_year_secondary - self.date_start_year + 12
            when '2nd quarter' then self.date_start_year_secondary - self.date_start_year + 12
            when '3rd quarter' then self.date_start_year_secondary - self.date_start_year + 12
            when '4th quarter' then self.date_start_year_secondary - self.date_start_year + 12
            when '1st half' then self.date_start_year_secondary - self.date_start_year+25
            when '2nd half' then self.date_start_year_secondary - self.date_start_year+25
            when 'beginCent' then self.date_start_year_secondary - self.date_start_year+12
            when 'midCent' then self.date_start_year_secondary - self.date_start_year + 16
            when 'precise' then self.date_start_year_secondary - self.date_start_year
            when 'endCent' then self.date_start_year_secondary - self.date_start_year + 12
            when 'openRight' then 2010
          end
        end
      end
      self.date_end_year = self.date_start_year 
      self.date_end_month = self.date_start_month
      self.date_end_day = self.date_start_day 
      self.date_end_plus_delta = self.date_start_plus_delta 
      if self.finish_date_start != nil
        self.date_end_year = case self.finish_encoding_type
          when 'openLeft' then self.date_end_year
          when 'turnCent' then self.date_end_year
          when 'circa' then self.date_end_year
          when 'Century' then self.date_end_year
          when '1st third' then self.date_end_year + 16
          when '2nd third' then self.date_end_year + 50
          when '3rd third' then self.date_end_year + 83
          when '1st quarter' then self.date_end_year + 12
          when '2nd quarter' then self.date_end_year + 37
          when '3rd quarter' then self.date_end_year + 62
          when '4th quarter' then self.date_start_year + 87
          when '1st half' then self.date_end_year+25
          when '2nd half' then self.date_end_year+75
          when 'beginCent' then self.date_end_year+12
          when 'midCent' then self.date_end_year + 50
          when 'precise' then self.date_end_year
          when 'endCent' then self.date_end_year + 87
          when 'openRight' then self.date_end_year
        end
        self.date_end_minus_delta = case self.finish_encoding_type
          when 'openLeft' then 2000
          when 'turnCent' then 10
          when 'circa' then 5
          when 'Century' then 0
          when '1st third' then 16
          when '2nd third' then 16
          when '3rd third' then 16
          when '1st quarter' then 12
          when '2nd quarter' then 12
          when '3rd quarter' then 12
          when '4th quarter' then 12
          when '1st half' then 25
          when '2nd half' then 25
          when 'beginCent' then 12
          when 'midCent' then 17
          when 'precise' then 0
          when 'endCent' then 12
          when 'openRight' then 0
        end
        self.date_end_plus_delta = case self.finish_encoding_type
          when 'openLeft' then 0
          when 'turnCent' then 10
          when 'circa' then 5
          when 'Century' then 99
          when '1st third' then 16
          when '2nd third' then 16
          when '3rd third' then 16
          when '1st quarter' then 12
          when '2nd quarter' then 12
          when '3rd quarter' then 12
          when '4th quarter' then 12
          when '1st half' then 25
          when '2nd half' then 25
          when 'beginCent' then 12
          when 'midCent' then 16
          when 'precise' then 0
          when 'endCent' then 12
          when 'openRight' then 2000
        end
        if self.date_end_century_secondary != nil  # add in plus delta for right bounds
          self.date_end_year_secondary = case self.finish_encoding_type_secondary
            when 'openLeft' then self.date_end_year_secondary
            when 'turnCent' then self.date_end_year_secondary
            when 'circa' then self.date_end_year_secondary
            when 'Century' then self.date_end_year_secondary
            when '1st third' then self.date_end_year_secondary + 16
            when '2nd third' then self.date_end_year_secondary + 50
            when '3rd third' then self.date_end_year_secondary + 83
            when '1st quarter' then self.date_end_year_secondary + 12
            when '2nd quarter' then self.date_end_year_secondary + 37
            when '3rd quarter' then self.date_end_year_secondary + 62
            when '4th quarter' then self.date_start_year_secondary + 87
            when '1st half' then self.date_end_year_secondary+25
            when '2nd half' then self.date_end_year_secondary+75
            when 'beginCent' then self.date_end_year_secondary+12
            when 'midCent' then self.date_end_year_secondary + 50
            when 'precise' then self.date_end_year_secondary
            when 'endCent' then self.date_end_year_secondary + 87
            when 'openRight' then self.date_end_year_secondary
          end
          self.date_end_plus_delta = case self.finish_encoding_type_secondary
            when 'openLeft' then self.date_end_year_secondary - self.date_end_year
            when 'turnCent' then self.date_end_year_secondary - self.date_end_year + 10
            when 'circa' then self.date_end_year_secondary - self.date_end_year + 5
            when 'Century' then self.date_end_year_secondary - self.date_end_year + 99
            when '1st third' then self.date_end_year_secondary - self.date_end_year + 16
            when '2nd third' then self.date_end_year_secondary - self.date_end_year + 16
            when '3rd third' then self.date_end_year_secondary - self.date_end_year + 16
            when '1st quarter' then self.date_end_year_secondary - self.date_end_year + 12
            when '2nd quarter' then self.date_end_year_secondary - self.date_end_year + 12
            when '3rd quarter' then self.date_end_year_secondary - self.date_end_year + 12
            when '4th quarter' then self.date_end_year_secondary - self.date_end_year + 12
            when '1st half' then self.date_end_year_secondary - self.date_end_year+25
            when '2nd half' then self.date_end_year_secondary - self.date_end_year+25
            when 'beginCent' then self.date_end_year_secondary - self.date_end_year+12
            when 'midCent' then self.date_end_year_secondary - self.date_end_year + 16
            when 'precise' then self.date_end_year_secondary - self.date_end_year
            when 'endCent' then self.date_end_year_secondary - self.date_end_year + 12
            when 'openRight' then 2010
          end
        end
      end
    end
    self.date_start_encoding_value = 90000  #precise
    
    temp_date_start_year = self.date_start_year
    if self.begin_encoding_type != nil
      self.date_start_encoding_value = case self.begin_encoding_type
        when 'openLeft' then 0
        when 'turnCent' then 10000
        when 'circa' then 20000
        when 'Century' then 30000
        when '1st third' then 40000
        when '2nd third' then 40000
        when '3rd third' then 40000
        when '1st quarter' then 50000
        when '2nd quarter' then 50000
        when '3rd quarter' then 50000
        when '4th quarter' then 50000
        when '1st half' then 60000
        when '2nd half' then 60000
        when 'beginCent' then 70000
        when 'midCent' then 80000
        when 'precise' then 90000
        when 'endCent' then 100000
        when 'openRight' then 120000
      end
      temp_date_start_year = case self.begin_encoding_type
        when 'openLeft' then 1000
        when 'turnCent' then temp_date_start_year - 10
        when 'circa' then temp_date_start_year - 5
        when 'Century' then temp_date_start_year
        when '1st third' then temp_date_start_year
        when '2nd third' then temp_date_start_year
        when '3rd third' then temp_date_start_year
        when '1st quarter' then temp_date_start_year
        when '2nd quarter' then temp_date_start_year
        when '3rd quarter' then temp_date_start_year
        when '4th quarter' then temp_date_start_year
        when '1st half' then temp_date_start_year
        when '2nd half' then temp_date_start_year
        when 'beginCent' then temp_date_start_year
        when 'midCent' then temp_date_start_year + 33
        when 'precise' then temp_date_start_year
        when 'endCent' then temp_date_start_year + 75
        # when 'openRight' then 120000
      end
    end
    if self.begin_type == 'century' or self.finish_date_start != nil
      self.date_span_value = 2000000
    else
      self.date_span_value = 1000000
    end
    if self.begin_date_start == nil
      self.begin_date_start = "#{self.date_start_year}-#{self.date_start_month}-#{self.date_start_day}"
      self.begin_date_center = "#{self.date_start_year}-#{self.date_start_month}-#{self.date_start_day}"
      self.begin_date_end = "#{self.date_start_year}-#{self.date_start_month}-#{self.date_start_day}"
    end
    if self.finish_date_start == nil and self.date_end_year != nil
      self.finish_date_start = "#{self.date_end_year}-#{self.date_end_month}-#{self.date_end_day}"
      self.finish_date_center = "#{self.date_end_year}-#{self.date_end_month}-#{self.date_end_day}"
      self.finish_date_end = "#{self.date_end_year}-#{self.date_end_month}-#{self.date_end_day}"
    end
    self.sort_order = (temp_date_start_year * 10000000) - (self.date_start_minus_delta * 10000000) + (self.date_start_month * 100) + self.date_start_encoding_value + self.date_span_value + self.date_start_day
  end
end