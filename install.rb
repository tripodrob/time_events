# Install hook code here

require 'fileutils'

model_dir = File.dirname(__FILE__) + "/../../../app/models"
controller_dir = File.dirname(__FILE__) + "/../../../app/controllers"
view_dir = File.dirname(__FILE__) + "/../../../app/views"
public_dir = File.dirname(__FILE__) + "/../../../public"
plugin_dir = File.dirname(__FILE__) + "/lib/app"

FileUtils.install(plugin_dir + "/controllers/time_events_controller.rb", controller_dir)
FileUtils.install(plugin_dir + "/models/time_event.rb", model_dir)
FileUtils.install(plugin_dir + "/controllers/time_events_controller.rb", controller_dir)

FileUtils.mkdir_p(view_dir + "/time_events")
FileUtils.install(plugin_dir + "/views/time_events/_begin_date_start_form_column.rhtml", view_dir + '/time_events')
FileUtils.install(plugin_dir + "/views/time_events/_event_duration.rhtml", view_dir + '/time_events')
FileUtils.install(plugin_dir + "/views/time_events/_form.rhtml", view_dir + '/time_events')
FileUtils.install(plugin_dir + "/views/time_events/edit.html.erb", view_dir + '/time_events')
FileUtils.install(plugin_dir + "/views/time_events/index.html.erb", view_dir + '/time_events')
FileUtils.install(plugin_dir + "/views/time_events/search_dates.html.erb", view_dir + '/time_events')
FileUtils.install(plugin_dir + "/views/time_events/search_dates_action.html.erb", view_dir + '/time_events')
FileUtils.install(plugin_dir + "/views/time_events/show.html.erb", view_dir + '/time_events')

plugin_dir = File.dirname(__FILE__) + "/public"
FileUtils.install(plugin_dir + "/javascripts/centerdecadedateslider.js", public_dir + '/javascripts')
FileUtils.install(plugin_dir + "/javascripts/centerdecadedateviewer.js", public_dir + '/javascripts')
FileUtils.install(plugin_dir + "/javascripts/date-en-US.js", public_dir + '/javascripts')
FileUtils.install(plugin_dir + "/javascripts/dateslider.js", public_dir + '/javascripts')
FileUtils.install(plugin_dir + "/javascripts/dateviewer.js", public_dir + '/javascripts')
FileUtils.install(plugin_dir + "/javascripts/decadedateslider.js", public_dir + '/javascripts')
FileUtils.install(plugin_dir + "/javascripts/precisedateslider.js", public_dir + '/javascripts')
FileUtils.install(plugin_dir + "/javascripts/precisedecadedateslider.js", public_dir + '/javascripts')

FileUtils.install(plugin_dir + "/stylesheets/dateslider.css", public_dir + '/stylesheets')

FileUtils.install(plugin_dir + "/images/slidbg.gif", public_dir + '/images')
