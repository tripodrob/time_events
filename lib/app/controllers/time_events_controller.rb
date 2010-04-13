class TimeEventsController < ApplicationController
  layout 'admin'
  
  protect_from_forgery :only => [:create, :update, :destroy] 
  
  active_scaffold do |config|
    # config.columns[:name].form_ui = :select
    # config.create.columns = [:begin_date_start, :begin_date_center,:begin_date_end,:finish_date_start, :finish_date_center,:finish_date_end,:begin_type, :begin_encoding_type, :finish_type, :begin_precise, :finish_precise]
    # config.update.columns = [:begin_date_start, :begin_date_center,:begin_date_end,:finish_date_start, :finish_date_center,:finish_date_end,:begin_type, :begin_encoding_type, :finish_type, :begin_precise, :finish_precise]
    config.columns << :display_english
    config.list.columns = [:begin_date_start, :begin_date_center,:begin_date_end,:finish_date_start, :finish_date_center,:finish_date_end, :sort_order, :display_english]
    config.columns.exclude :created_at, :updated_at
  end
  
  def search_dates
    
  end
  def search_dates_action
    @results = TimeEvent.find :all
    hash = {}
    start = params['start_year'].to_i*10000
    start += params['start_month'] != nil ? params['start_month'].to_i * 100 : 0
    start += params['start_day'] != nil ? params['start_day'].to_i : 0
    stop = params['end_year'].to_i*10000
    stop += params['end_month'] != nil ? params['end_month'].to_i * 100 : 0
    stop += params['end_day'] != nil ? params['end_day'].to_i : 0
    conditions = []
    db_start = '(((date_start_year-date_start_minus_delta)*10000)+(date_start_month*100)+(date_start_day))'
    # need to check for things with no end year!
    db_stop = '(((date_end_year+date_end_plus_delta)*10000)+(date_end_month*100)+(date_end_day))'
    if params['event_type'] == 'during'
      # dbs > start and dbs < stop
      conditions << "((#{db_start} >= #{start}) and (#{db_start} <= #{stop}))"
      # dbs < start and dbe > start
      conditions << "((#{db_start} <= #{start}) and (#{db_stop} >= #{start}))"
    else
      conditions << "((#{db_start} >= #{start}) and (#{db_start} <= #{stop})) and (((#{db_stop} >= #{start}) and (#{db_stop} <= #{stop})) or (\"date_end_year\" = '0'))"
    end
    cond = ''
    conditions.map {|o| cond != '' ? cond = cond + ' or ' : ''; cond += o}
    @c = cond
    # @d = db_start
    # debugger
    # @records = TimeEvent.find(:all, :conditions => cond)
    # redirect_to :action => 'list', :params => hash
    # render :active_scaffold => 'time_events', :conditions => cond, :label => "#{params['start_year']}-#{params['end_year']}"
  end
end
