class EventsController < ApplicationController

  def eventing
    @record = Record.find(params[:id])
    @events = Event.find(:all, :conditions => ["record_id = ?", @record.id ], :order => "id" )
    @event = @events[0]
  end
  def next_event
    @e = Event.find(params[:id])
    @event_record = @e.record.id
    @events = Event.find(:all, :conditions =>["record_id = ? ", @event_record], :order => "id")
    @event = Event.find(:all, :conditions => ["id > ? and record_id = ?", params[:id], @event_record ], :limit => 1, :order => "id" )
    @event = @event[0]
    respond_to do |format|
      format.js
    end
  end
  def last_event
    @e = Event.find(params[:id])
    @event_record = @e.record.id
    @events = Event.find(:all, :conditions =>["record_id = ? ", @event_record], :order => "id")
    @event = Event.find(:all, :conditions => ["id < ? and record_id = ?", params[:id], @event_record ], :limit => 1, :order => "id desc" )
    @event = @event[0]
    respond_to do |format|
      format.js
    end
  end
  def never_event
    @e = Event.find(params[:id])
    @event_record = @e.record.id
    @events = Event.find(:all, :conditions =>["record_id = ? ", @event_record], :order => "id")
    @event = Event.find(:all, :conditions => ["record_id = ? and akey = ''", @event_record ], :order => "id")
    @event = @event[0]
    respond_to do |format|
      format.js
    end
  end
  def go_event
    @e = Event.find(params[:id])
    @event_record = @e.record.id
    @events = Event.find(:all, :conditions =>["record_id = ? ", @event_record], :order => "id")
    @event = Event.find(:all, :conditions => ["id = ? and record_id = ?", params[:id], @event_record ], :limit => 1, :order => "id desc" )
    @event = @event[0]
    respond_to do |format|
      format.js
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.record.limit_time >= Time.now
      if @event.typies == "single"
        @event.update_attribute(:akey, params[:event][:akey])
      end
      if @event.typies == "much"
        @_key=""
        @_key += params[:key_a] unless params[:key_a].blank?
        @_key += params[:key_b] unless params[:key_b].blank?
        @_key += params[:key_c] unless params[:key_c].blank?
        @_key += params[:key_d] unless params[:key_d].blank?
        @_key += params[:key_e] unless params[:key_e].blank?
        @_key += params[:key_f] unless params[:key_f].blank?
        @_key += params[:key_g] unless params[:key_g].blank?
        @_key += params[:key_h] unless params[:key_h].blank?
        @_key += params[:key_i] unless params[:key_i].blank?
        @_key += params[:key_j] unless params[:key_j].blank?
        @event.update_attribute(:akey, @_key )
      end
      if @event.typies == "judge"
        @event.update_attribute(:akey,params[:event][:akey])
      end
      @event.update_attribute(:session_id, session[:event]) if @event.session_id.blank?
      @event.record.update_attribute(:finish_time, Time.now)
    end
  end

  def began_event
    @event_record = Record.find(params[:id])
    if ["new","doing"].include?(@event_record.state)
      @event_record.update_attribute(:limit_time, Time.now + @event_record.need_time)  if @event_record.state == "new"
      @event_record.update_attribute(:state, "doing")
      @event_record.update_attribute(:start_time, Time.now) if @event_record.start_time.blank?
      @events = Event.find(:all,:conditions => ["record_id = ?", @event_record.id ],  :order => "id")
      @event = @events[0]
      respond_to do |format|
        format.js
      end
    else
      redirect_to records_path
    end
  end
end
