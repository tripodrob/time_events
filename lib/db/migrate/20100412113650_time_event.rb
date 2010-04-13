class TimeEvent < ActiveRecord::Migration
  def self.up
    create_table "time_events", :force => true do |t|
      t.string   "begin_date_start"
      t.string   "begin_date_end"
      t.string   "finish_date_start"
      t.string   "finish_date_end"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "begin_date_center",              :limit => 128
      t.string   "finish_date_center"
      t.boolean  "begin_precise"
      t.boolean  "finish_precise"
      t.string   "begin_type",                     :limit => nil, :default => "day"
      t.string   "finish_type",                    :limit => nil, :default => "day"
      t.string   "begin_encoding_type",            :limit => nil
      t.integer  "begin_date_minus_delta"
      t.integer  "begin_date_plus_delta"
      t.integer  "finish_date_minus_delta"
      t.integer  "finish_date_plus_delta"
      t.integer  "sort_order",                     :limit => 8,   :default => 0
      t.integer  "date_start_year",                               :default => 0
      t.integer  "date_start_month",                              :default => 0
      t.integer  "date_start_day",                                :default => 0
      t.integer  "date_start_plus_delta",                         :default => 0
      t.integer  "date_start_minus_delta",                        :default => 0
      t.integer  "date_end_minus_delta",                          :default => 0
      t.integer  "date_end_plus_delta",                           :default => 0
      t.integer  "date_end_day",                                  :default => 0
      t.integer  "date_end_month",                                :default => 0
      t.integer  "date_end_year",                                 :default => 0
      t.integer  "date_start_encoding_value"
      t.integer  "date_span_value",                               :default => 0
      t.string   "finish_encoding_type",           :limit => nil
      t.integer  "date_start_year_secondary"
      t.integer  "date_end_year_secondary"
      t.string   "begin_encoding_type_secondary",  :limit => nil
      t.string   "finish_encoding_type_secondary", :limit => nil
      t.integer  "date_start_century"
      t.integer  "date_start_century_secondary"
      t.integer  "date_end_century"
      t.integer  "date_end_century_secondary"
    end

  end

  def self.down
  end
end
